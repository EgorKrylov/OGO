///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем КонтекстВыбора;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Объект.Ссылка.Пустая() Тогда
		Взаимодействия.УстановитьПредметПоДаннымЗаполнения(Параметры, Предмет);
	КонецЕсли;
	Взаимодействия.ЗаполнитьСписокВыбораДляРассмотретьПосле(Элементы.РассмотретьПосле.СписокВыбора);
	
	// Определим типы контактов, которые можно создать.
	СписокИнтерактивноСоздаваемыхКонтактов = Взаимодействия.СоздатьСписокЗначенийИнтерактивноСоздаваемыхКонтактов();
	Элементы.СоздатьКонтакт.Видимость      = СписокИнтерактивноСоздаваемыхКонтактов.Количество() > 0;
	
	// Подготовить оповещения взаимодействий.
	Взаимодействия.ПодготовитьОповещения(ЭтотОбъект, Параметры);
	
	// СтандартныеПодсистемы.Свойства
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "СтраницаДополнительныеРеквизиты");
		ДополнительныеПараметры.Вставить("ОтложеннаяИнициализация", Истина);
		МодульУправлениеСвойствами = ОбщегоНазначения.ОбщийМодуль("УправлениеСвойствами");
		МодульУправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		МодульВерсионированиеОбъектов = ОбщегоНазначения.ОбщийМодуль("ВерсионированиеОбъектов");
		МодульВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	КонецЕсли;
	
	ПриСозданииИПриЧтенииНаСервере();
	
	Взаимодействия.ЗаполнитьСписокВыбораВремени(Элементы.ВремяНачала, 1800);
	Взаимодействия.ЗаполнитьСписокВыбораВремени(Элементы.ВремяОкончания, 1800);
	
	// СтандартныеПодсистемы.РаботаСФайлами
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайлами = ОбщегоНазначения.ОбщийМодуль("РаботаСФайлами");
		ГиперссылкаФайлов = МодульРаботаСФайлами.ГиперссылкаФайлов();
		ГиперссылкаФайлов.Размещение = "КоманднаяПанель";
		МодульРаботаСФайлами.ПриСозданииНаСервере(ЭтотОбъект, ГиперссылкаФайлов);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.РаботаСФайлами

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствами = ОбщегоНазначения.ОбщийМодуль("УправлениеСвойствами");
		МодульУправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	ПриСозданииИПриЧтенииНаСервере();
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	ОбновитьОтображениеДанных();
	ПроверитьДоступностьСозданияКонтакта();
	
	// СтандартныеПодсистемы.РаботаСФайлами
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСФайламиКлиент");
		МодульРаботаСФайламиКлиент.ПриОткрытии(ЭтотОбъект, Отказ);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.РаботаСФайлами

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	// СтандартныеПодсистемы.Свойства
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		Если МодульУправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
			ОбновитьЭлементыДополнительныхРеквизитов();
			МодульУправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
		КонецЕсли;
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	ВзаимодействияКлиент.ОтработатьОповещение(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	ВзаимодействияКлиентСервер.ПроверитьЗаполнениеКонтактов(Объект, ЭтотОбъект, "Встреча");
	ПроверитьДоступностьСозданияКонтакта();
	
	// СтандартныеПодсистемы.РаботаСФайлами
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСФайламиКлиент");
		МодульРаботаСФайламиКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.РаботаСФайлами

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, РежимЗаписи, РежимПроведения)
	
	// СтандартныеПодсистемы.Свойства
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствами = ОбщегоНазначения.ОбщийМодуль("УправлениеСвойствами");
		МодульУправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Взаимодействия.ПередЗаписьюВзаимодействияИзФормы(ЭтотОбъект, ТекущийОбъект, ИзменилисьКонтакты);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Взаимодействия.ПриЗаписиВзаимодействияИзФормы(ТекущийОбъект, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	ВзаимодействияКлиент.ВзаимодействиеПредметПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи, "Встреча");
	ПроверитьДоступностьСозданияКонтакта();
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	Элементы.СтраницаКомментарий.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Комментарий);

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствами = ОбщегоНазначения.ОбщийМодуль("УправлениеСвойствами");
		МодульУправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	ВзаимодействияКлиент.ФормаОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение, ИсточникВыбора, КонтекстВыбора);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СтраницыОписаниеУчастникиДополнительноПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	// СтандартныеПодсистемы.Свойства
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства")
		И ТекущаяСтраница.Имя = "СтраницаДополнительныеРеквизиты"
		И Не ЭтотОбъект.ПараметрыСвойств.ВыполненаОтложеннаяИнициализация Тогда
		
		СвойстваВыполнитьОтложеннуюИнициализацию();
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура РассмотретьПослеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ВзаимодействияКлиент.ОбработатьВыборВПолеРассмотретьПосле(
		РассмотретьПосле, ВыбранноеЗначение, СтандартнаяОбработка, Модифицированность);
	
КонецПроцедуры

&НаКлиенте
Процедура ВремяНачалаПриИзменении(Элемент)

	Объект.ДатаНачала = НачалоДня(Объект.ДатаНачала) + ВыделитьВремя(ВремяНачала);
	Объект.ДатаОкончания = Объект.ДатаНачала + Продолжительность;
	ВремяОкончания = Объект.ДатаОкончания;

КонецПроцедуры

&НаКлиенте
Процедура ВремяОкончанияПриИзменении(Элемент)

	Если НачалоДня(Объект.ДатаОкончания) + ВыделитьВремя(ВремяОкончания) < Объект.ДатаНачала Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru='Время окончания не может быть меньше времени начала.'"),,"ВремяОкончания");
		ВремяОкончания = ВремяНачала + 1800;
		Объект.ДатаОкончания = НачалоДня(Объект.ДатаОкончания) + ВыделитьВремя(ВремяОкончания);
		Возврат;
	КонецЕсли;

	Объект.ДатаОкончания = НачалоДня(Объект.ДатаОкончания) + ВыделитьВремя(ВремяОкончания);
	Продолжительность = Объект.ДатаОкончания - Объект.ДатаНачала;

КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаПриИзменении(Элемент)

	Объект.ДатаНачала = НачалоДня(ДатаНачала) + ВыделитьВремя(ВремяНачала);
	Объект.ДатаОкончания = Объект.ДатаНачала + Продолжительность;
	ДатаОкончания = Объект.ДатаОкончания;

КонецПроцедуры

&НаКлиенте
Процедура ДатаОкончанияПриИзменении(Элемент)

	Если НачалоДня(ДатаОкончания) + ВыделитьВремя(ВремяОкончания) < Объект.ДатаНачала Тогда
		ОчиститьСообщения();
		Если НачалоДня(ДатаОкончания) < НачалоДня(ДатаНачала) Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru='Дата окончания не может быть меньше даты начала.'"),,"ДатаОкончания");
		Иначе
			ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru='Время окончания не может быть меньше времени начала.'"),,"ВремяОкончания");
		КонецЕсли;
		ДатаОкончания = Объект.ДатаНачала;
		Объект.ДатаОкончания = НачалоДня(ДатаОкончания) + ВыделитьВремя(ВремяОкончания);
		Возврат;
	КонецЕсли;

	Объект.ДатаОкончания = НачалоДня(ДатаОкончания) + ВыделитьВремя(ВремяОкончания);
	Продолжительность = Объект.ДатаОкончания - Объект.ДатаНачала;

КонецПроцедуры

&НаКлиенте
Процедура РассмотреноПриИзменении(Элемент)
	
	Элементы.РассмотретьПосле.Доступность = НЕ Рассмотрено;
	
КонецПроцедуры

&НаКлиенте
Процедура ПредметНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ВзаимодействияКлиент.ПредметНачалоВыбора(ЭтотОбъект, Элемент, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраНажатие(Элемент, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСФайламиКлиент");
		МодульРаботаСФайламиКлиент.ПолеПредпросмотраНажатие(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСФайламиКлиент");
		МодульРаботаСФайламиКлиент.ПолеПредпросмотраПроверкаПеретаскивания(ЭтотОбъект, Элемент,
			ПараметрыПеретаскивания, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеПредпросмотраПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСФайламиКлиент");
		МодульРаботаСФайламиКлиент.ПолеПредпросмотраПеретаскивание(ЭтотОбъект, Элемент,
			ПараметрыПеретаскивания, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУчастники

&НаКлиенте
Процедура УчастникиПриИзменении(Элемент)
	
	ВзаимодействияКлиентСервер.ПроверитьЗаполнениеКонтактов(Объект, ЭтотОбъект, "Встреча");
	ИзменилисьКонтакты = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура УчастникиПриАктивизацииСтроки(Элемент)
	
	ПроверитьДоступностьСозданияКонтакта();
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	текДанные = Элементы.Участники.ТекущиеДанные;
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ТолькоEmail",                       Ложь);
	ПараметрыОткрытия.Вставить("ТолькоТелефон",                     Ложь);
	ПараметрыОткрытия.Вставить("ЗаменятьПустыеАдресИПредставление", Истина);
	ПараметрыОткрытия.Вставить("ДляФормыУточненияКонтактов",        Ложь);
	ПараметрыОткрытия.Вставить("ИдентификаторФормы",                УникальныйИдентификатор);
	
	ВзаимодействияКлиент.ВыбратьКонтакт(Предмет, текДанные.КакСвязаться, текДанные.ПредставлениеКонтакта,
		                                текДанные.Контакт, ПараметрыОткрытия) 
		
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеКонтактаПриИзменении(Элемент)
	
	ПроверитьДоступностьСозданияКонтакта();
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Участники.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ВзаимодействияВызовСервера.ПредставлениеИВсяКонтактнаяИнформациюКонтакта(ТекущиеДанные.Контакт,
		                                                                         ТекущиеДанные.ПредставлениеКонтакта,
		                                                                         ТекущиеДанные.КакСвязаться);
	КонецЕсли;

	ПроверитьДоступностьСозданияКонтакта();
	ВзаимодействияКлиентСервер.ПроверитьЗаполнениеКонтактов(Объект, ЭтотОбъект, "Встреча");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьКонтактВыполнить()
	
	текДанные = Элементы.Участники.ТекущиеДанные;
	Если текДанные <> Неопределено Тогда
		ВзаимодействияКлиент.СоздатьКонтакт(
			текДанные.ПредставлениеКонтакта, текДанные.КакСвязаться, Объект.Ссылка, СписокИнтерактивноСоздаваемыхКонтактов);
	КонецЕсли;
	
КонецПроцедуры

// СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

// СтандартныеПодсистемы.РаботаСФайлами
&НаКлиенте
Процедура Подключаемый_КомандаПанелиПрисоединенныхФайлов(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСФайламиКлиент");
		МодульРаботаСФайламиКлиент.КомандаУправленияПрисоединеннымиФайлами(ЭтотОбъект, Команда);
	КонецЕсли;
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.РаботаСФайлами

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПроверитьДоступностьСозданияКонтакта()
	
	ТекДанные = Элементы.Участники.ТекущиеДанные;
	Элементы.СоздатьКонтакт.Доступность = (Не Объект.Ссылка.Пустая()) 
	                                      И ((ТекДанные <> Неопределено) 
	                                      И (НЕ ЗначениеЗаполнено(ТекДанные.Контакт)));
	
КонецПроцедуры

&НаКлиенте
Функция ВыделитьВремя(Дата)

	Возврат Час(Дата) * 3600 + Минута(Дата) * 60;

КонецФункции

&НаСервере
Процедура ПриСозданииИПриЧтенииНаСервере()
	
	ДатаНачала        = Объект.ДатаНачала;
	ВремяНачала       = Объект.ДатаНачала;
	ДатаОкончания     = Объект.ДатаОкончания;
	ВремяОкончания    = Объект.ДатаОкончания;
	Продолжительность = Объект.ДатаОкончания - Объект.ДатаНачала;
	
	Если Не Объект.Ссылка.Пустая() Тогда
		Взаимодействия.УстановитьРеквизитыФормыВзаимодействияПоДаннымРегистра(ЭтотОбъект);
	Иначе
		ИзменилисьКонтакты = Истина;
	КонецЕсли;
	
	ВзаимодействияКлиентСервер.ПроверитьЗаполнениеКонтактов(Объект, ЭтотОбъект, "Встреча");
	Элементы.РассмотретьПосле.Доступность = НЕ Рассмотрено;
	Элементы.СтраницаКомментарий.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Комментарий);
	
КонецПроцедуры

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствами = ОбщегоНазначения.ОбщийМодуль("УправлениеСвойствами");
		МодульУправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствами = ОбщегоНазначения.ОбщийМодуль("УправлениеСвойствами");
		МодульУправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти
