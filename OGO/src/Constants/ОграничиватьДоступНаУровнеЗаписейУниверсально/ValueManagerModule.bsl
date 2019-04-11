///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

Перем СтароеЗначение;

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СтароеЗначение = Константы.ОграничиватьДоступНаУровнеЗаписейУниверсально.Получить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Значение И Не СтароеЗначение Тогда // Включено.
		Если Не Константы.ОграничиватьДоступНаУровнеЗаписей.Получить() Тогда
			ТекстОшибки =
				НСтр("ru = 'Чтобы включить константу ""Ограничивать доступ на уровне записей универсально""
				           |сначала нужно включить константу ""Ограничивать доступ на уровне записей"".'");
			ВызватьИсключение ТекстОшибки;
		КонецЕсли;
		МенеджерЗначения = Константы.ПоследнееОбновлениеДоступа.СоздатьМенеджерЗначения();
		МенеджерЗначения.Значение = Новый ХранилищеЗначения(Неопределено);
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(МенеджерЗначения);
		НаборЗаписей = РегистрыСведений.ПараметрыОграниченияДоступа.СоздатьНаборЗаписей();
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(НаборЗаписей);
		РегистрыСведений.ПараметрыОграниченияДоступа.ОбновитьДанныеРегистра();
	КонецЕсли;
	
	Если Не Значение И СтароеЗначение Тогда // Выключено.
		УправлениеДоступомСлужебный.ВключитьЗаполнениеДанныхДляОграниченияДоступа();
	КонецЕсли;
	
	Если Значение <> СтароеЗначение Тогда // Изменено.
		// Обновление параметров сеанса.
		// Требуется для того, чтобы администратор не выполнял перезапуск.
		УстановленныеПараметры = Новый Массив;
		УправлениеДоступомСлужебный.УстановкаПараметровСеанса("", УстановленныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли