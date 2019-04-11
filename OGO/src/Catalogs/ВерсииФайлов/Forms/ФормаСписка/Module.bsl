///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	// Оформление помеченных на удаление.
	ЭлементУсловногоОформления = Список.УсловноеОформление.Элементы.Добавить();
	
	ЭлементЦветаОформления = ЭлементУсловногоОформления.Оформление.Элементы.Найти("TextColor");
	ЭлементЦветаОформления.Значение = Метаданные.ЭлементыСтиля.ТекстЗапрещеннойЯчейкиЦвет.Значение;
	ЭлементЦветаОформления.Использование = Истина;
	
	ЭлементОтбораДанных = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбораДанных.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
	ЭлементОтбораДанных.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбораДанных.ПравоеЗначение = Истина;
	ЭлементОтбораДанных.Использование  = Истина;
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.СписокКомментарий.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_Файл"
	   И Параметр.Свойство("Событие")
	   И (    Параметр.Событие = "ЗаконченоРедактирование"
	      ИЛИ Параметр.Событие = "ВерсияСохранена") Тогда
		
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ДанныеФайла = РаботаСФайламиСлужебныйВызовСервера.ДанныеФайлаДляОткрытия(ВладелецФайла(ВыбраннаяСтрока), ВыбраннаяСтрока, УникальныйИдентификатор);
	РаботаСФайламиСлужебныйКлиент.ОткрытьВерсиюФайла(Неопределено, ДанныеФайла, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередУдалением(Элемент, Отказ)
	
	ДанныеФайла = РаботаСФайламиСлужебныйВызовСервера.ДанныеФайла(Элементы.Список.ТекущаяСтрока);
	Если ДанныеФайла.ТекущаяВерсия = Элементы.Список.ТекущаяСтрока Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Активную версию нельзя удалить.'"));
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
	ОткрытьКарточкуФайла();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОткрытьКарточкуФайла()
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда 
		
		Версия = ТекущиеДанные.Ссылка;
		
		ПараметрыОткрытияФормы = Новый Структура("Ключ", Версия);
		ОткрытьФорму("Обработка.РаботаСФайлами.Форма.ВерсияПрисоединенногоФайла", ПараметрыОткрытияФормы);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВладелецФайла(ВыбраннаяСтрока)
	Возврат ВыбраннаяСтрока.Владелец;
КонецФункции


#КонецОбласти