Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17A537257
	for <lists+linux-fpga@lfdr.de>; Sun, 29 May 2022 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiE2T1l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 15:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE2T1k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 15:27:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71B11164;
        Sun, 29 May 2022 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653852455; x=1685388455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XBibDKUjUPP6XEsK95QWPkHqbpQm+SmgeHrQvH8BEaQ=;
  b=fIh13czahBtYDrBalcGx4JqHclb/prloAfXGj8Q0WwWwKas5xeysDxPz
   nVm5wvIMnKh+o7vNRoJ7Ijo8DSIGkFNm90hVjL0JiIUly3KijoFBOmtDu
   6pxTTIU5h9Ic6ud5SnYrmm2BGGigVaO6ePI9ohcIa1FX1HELW4hBMpWnO
   M1dl1UcxDHuP8SibSx4G4oQBEM+2w295Bh5SyZUXmYeXwdEgnWH4zOVFi
   PP6hDCuAzIeVC/cG+M3q+4WRTO4+CITbEVBCb+v5l2o8BEb+LMqtgBtqM
   +fzUSBmhqU15ymrSGFxK1UoJJtBUVEBvD3cqruKyC1dO+G8slWYy7R9Kt
   A==;
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="175588325"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2022 12:27:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 29 May 2022 12:27:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 29 May 2022 12:27:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da5/zvMJNPXCYqKopEE2Tm9iG0PbzmEeP46CS8MFBEaHcqMznBvyGH/Cc2rnryisdV1i7KqNzcu+qfktSp+80nTZxSce7xM2jHly8UQelcDKQCpNx8dOMmblL6qJy+SZthOlx9gxCXwThSCGEBnUSmF++W5i9UI2pM2xmS0yAlSJ/53XHUZuz9z7gE2OLVS6G/DDw0YI27yCEf9LvRhlU9+4VxfDtf8xBelhwWCnzEuzHr/C2aUX5ldBh26mrF8yvaa5yPEEOSjkNea7PEFoX1gy1w6uIWK6gsXoaVgkNLOmyMnDnH1rcyIzPiZfdIfhoI3G5ecoWNRQLcau88gzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBibDKUjUPP6XEsK95QWPkHqbpQm+SmgeHrQvH8BEaQ=;
 b=Yqxy+G5wyGmEpsjBweBXQCaTNkpXciYafFhumVzHG+P3tkmIar+uhYTsAIPLjna9R97n8EONu2CA5/Sb8QbSxhYsmWMqu04oI+dg3T2uFiFcBljQqO4X+v7U9/wAyAvnd+56NnI6l7ODAFr7mBwp4+ru8AixAijWGOJmojc8Dydm3Ynlu9Ic7IHdWOSPKcrAzFKi/Yvo33GAk2g/Nr5IC6pHG3DjZFDpSfhMQBvghT2zdjEVdaJftPV9Y1OWiH+g5kpa6AJ1zIZ75Z1DUcQG/7xrHuc1SlfsEwviZzpq2lR9iuY5tiCQBKNd2lbpnu3LW/5xjZcyggpZnVoMajruQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBibDKUjUPP6XEsK95QWPkHqbpQm+SmgeHrQvH8BEaQ=;
 b=ddpt3yntctSyxIJY9mOPEkeA4BqMRSyx6gJph3MXIef14PPg5RDRiywFozUuCA0frAI6jp7IfZ19AkkBrqZTOTca2qGVzEmG+kCoDv6axFRszp+qRRgpxwOL/NZOEsVVUGMp3gAP9Vgv+LwVjk9b/i9iuCziKb3DcisV/QBaFJo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3076.namprd11.prod.outlook.com (2603:10b6:208:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sun, 29 May
 2022 19:27:28 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.019; Sun, 29 May 2022
 19:27:28 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>, <Conor.Dooley@microchip.com>
CC:     <yilun.xu@intel.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <system@metrotek.ru>
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYcS+MqDCo1uYFDUerOTfzxMPcoq010AUAgAAGgACAAGF0AIAACeqA
Date:   Sun, 29 May 2022 19:27:27 +0000
Message-ID: <74a0b69b-66b6-1abc-f25d-0ce3c16953b2@microchip.com>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <20220529123954.GB185904@yilunxu-OptiPlex-7050>
 <3d44115c-08c8-07ee-e707-617cfbe0352f@microchip.com>
 <20220529185158.gjoxrb65gpnh4g3k@x260>
In-Reply-To: <20220529185158.gjoxrb65gpnh4g3k@x260>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a604f73b-49c3-495d-19f5-08da41a9445a
x-ms-traffictypediagnostic: BL0PR11MB3076:EE_
x-microsoft-antispam-prvs: <BL0PR11MB307625FDABBF80AE3CB8F82498DA9@BL0PR11MB3076.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GztSHjj15GZxgSDbE+QCClrWGQejh7ciT8cTZJAPF5hCsicOI0Wkj0kKwh7VwD1uaz7gHeIZ1CHYD6pZbTYkRYALEMPlYB0rhPJbH3jBgQjGRUhLNLgI/bAhpiroySERZQFbVkRVd1n1zVyjrf3/bph8IcQqzCniCIjdALVXXfPKQKNgXKjhfc+JOHr+8Kj51RRJEubsa6HbqXRtTNPFzRDFCycM8OjqD8Zsi9YyWCRaBBLalat/dB9BY8aUmpMHlKqSO5oQCXQO0P/ks73Ly9oThg+8ZbQ76WUaZGvU3MIiWl8CRs/7D3B0QDGj9jKzKUHIM1dhFrrzogp8xQkIkTaHZFn+CqlVIQLvRjdcRMINP0pGQKO55r5W63bTXHwWrq9a+04B9T3yXm5b8b7QWxyQh0pev8bOXZTiNc7wWstQlmIBCeAj6yjeIFwI3W/1PRr/kHPgVJ4MlrZYnCuB28LsgEpyxylHiKZU/1E/u4rfBjUlGTm0TsHBx/Hahsm2A3f1WDNtOOH6Ng1z1Xpu6c2ZmETGOIDRyY3NeXOO7OzmRVdXtRhnd4lxmdjSSOqhGiPnh8zpew0OLde+3RCBsOT50OoPAL9CiZj4jXtjgSNOIrFuEm1GN+dr1H8DpofZncTQYdtQ4UKTlnLmWW773Wte1FAP44GdgaG3SoS6CO8IkD4dEsGjN8/7Q9eRunGNk6PTa6YMFEd9HHyadX/W7fjwxN0t14mJrK6etGiL5uhqK6EhZ1DWkZPjHWRZEIF22j32wlZBmuQjEuYb5Ghx4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(38100700002)(110136005)(54906003)(36756003)(316002)(8676002)(4326008)(66556008)(66946007)(91956017)(64756008)(66476007)(66446008)(76116006)(38070700005)(83380400001)(31686004)(8936002)(71200400001)(31696002)(6506007)(86362001)(6486002)(53546011)(7416002)(508600001)(5660300002)(122000001)(26005)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THFKaVFkcGtabXpuM3UzYzJVYzFIWFFpeTVqVzlUcFFhRC9yd2FGWFZGc1dC?=
 =?utf-8?B?N0tGS05sVjA1NWpGczg5WkVucWJoaDZzajdreG5mL09mWlFiYy9NMDlSeklD?=
 =?utf-8?B?VjdQQko5cENIUkt6SVk3V0FPaEI3Q0F2dElUM3RCQTFlZXpiT3JWSVRHY1BD?=
 =?utf-8?B?YTY1N3RBa3hXdTg0S2oyWXlRRzlBN3NuV21JcTY5b2JIVk8yMlJqZTVhUDUx?=
 =?utf-8?B?MmJUcGZ4b1JNVmpLR0p1SjlzdnF2WGR5TjQ1bzZzREJBalEra1dNOTV3ZEsv?=
 =?utf-8?B?dkEvbVVmOE5CWncwWFRCTFJ1UGRPSHEzK29iaENvMXVrSit3Nll4Y2ZkM1Ju?=
 =?utf-8?B?UkpDb0tPYTBmc0dkNGRVMTh4OGE5dG1lcmk3ZDJ6UHRGZUNZZWtIcks1NVJF?=
 =?utf-8?B?Y2RrSSthL3dMVXJRbWViWFZYeGc5SWgveFN4Rk1FY1grOTlVTWNVWCt2RzND?=
 =?utf-8?B?b3JIS2UwZ3MyaENFWjl3TzRXUnNjVlRmTGVFRWV4dmFOWGhhY0xGSGRhdUJi?=
 =?utf-8?B?aTN6aEFhdUZVVk1KWDQ3NHhCWmxLR0VnZGR4ZHc4K25JSHdMTXF1cjgzdURa?=
 =?utf-8?B?WmxiNXNHVEQ5T0VnTEk1THBweDVwZ0FaYWVrY1dRT25NeUZmR1hZQnlNUFUv?=
 =?utf-8?B?L29pVUMrcm5ESk5SbU5pZEUyVDBsTnVzNDJxZ3FvbWRmbVA1RWV0ejllZ3FQ?=
 =?utf-8?B?aUZSYXRHMStjMkg1aVZKOTF6RGQwUVVnb0phUFpsT2lRc3hvd0ZCM3BnYUFo?=
 =?utf-8?B?bDFEQlQvbmNBVmtsNUNQRlQ4bTNSOVBaRFZMeFVTR0YxenkrWldySzc2MkJj?=
 =?utf-8?B?dnlKVkNsSVFiNGVZMmpIbEtaOERFaXVNVUt6Zk9QdEpGSUlQWUUrYkNOa0dw?=
 =?utf-8?B?NHorQVF4enpManBmTW4wS1EyV0FxNWJFWXozZVRDUGE1RXlqUWt6Y3BkeUQ4?=
 =?utf-8?B?eTRDZEQ3UDlmMTUwcC9xZ3QzOFBVb2RwUHlpT1IySEFXaUJxWFNxS0pCVGha?=
 =?utf-8?B?RCtmTmFuTEN3UUQ0S0wvR1NUaGd5RS9nQlo4cCtwRnZ6UTIrQVM3eXVFQmZq?=
 =?utf-8?B?a0tod1A3WnVSKy8za0JhWGZpVHhPbDdYSVV1SGhOMkxybWR0MW9TWk9CZXRl?=
 =?utf-8?B?c2R6Yk0rM0JsT01uSkR1eHJPZHp6cHpJTUFSc3dUcjdUaDBYU3hvdXJGS2lI?=
 =?utf-8?B?NmtkTVBIckg5Y3I2ZUZQdDRiWW9CbGNhc0NONWVsRHRNb0UvRjFLbjlHTWJi?=
 =?utf-8?B?dFN5OUgyZ1hHOGErcERGb001d0FQQ2RSUlpCbFBCMzFob0p0SzN1dUJoWEVC?=
 =?utf-8?B?Z0REOXpZQzNoellGWTVVMFhkL29NVE1DNUc2MDZRWktzRU1ONm8vV2ZzTUY4?=
 =?utf-8?B?Ui90QlVSVVVRQkkwY0hNTXJOZFRTcnFVN0FaZ1NZMTM0MStMdnQ5Ykxvc3ZM?=
 =?utf-8?B?Uy9rUjNqd25qK1VRZjJtSE4yM1lGQVlTU0hkV25QUk5BMUViNTJSWWFLR29D?=
 =?utf-8?B?VURnMk9CbnY0bkRKbG5DOHZUbXAvaWNhVituZ0tzMFRiMExnOENsMnovTkti?=
 =?utf-8?B?ZFZHcjVDdWxEN3JpcHRUcXNQK3lteG8xQXl4S1pGMHlGTzBjZzA0M09NUWVU?=
 =?utf-8?B?TVZ6V0EyY3dpdGpxdVVQTzBqQWdQTW9SdjVRWEJ2S2w5TDRvRWpmN1BWS2Zp?=
 =?utf-8?B?b2dLWXFiSjRydVkwMEU5S1B0K09hUXRyOHVPc3dIZURRQ1BHOXZQYjFzbEt0?=
 =?utf-8?B?VXhjbW9zcWxUbmw0ajQ4aDVHWE1VRFFLNTI3Tko3eCtiTllzelBleHRpcysy?=
 =?utf-8?B?aElsR2F3WmVlVUFvekpJQVNBMk50T25TZGJhTGdnbkZVaHJwY1RDRVcxeHpB?=
 =?utf-8?B?RmU4RVlPUTY2NnpXbUJVSGZLRVhGTHYxMHZJNGVaaFFXOXAyc01jWkdPRDVK?=
 =?utf-8?B?RzdjSzVaZjQ0MFhuODBMcDhhVEhDcTZHRGE1bHVTTHlJVEFBdkJ5SElsclJM?=
 =?utf-8?B?dXVMb09pUDJIMnUzdkk2aE9hanM5NzJJQVBWM2N5b1NjNEl4cCtUR3laeDFI?=
 =?utf-8?B?MnUwTktGaXFBbFAzbUZhWDhuWVEyQ1pxaWVFb3UzY3g1TjZoa2hLMWpZM1Mv?=
 =?utf-8?B?UWhzVjZWS2x6aHFZVEVJVmNDYzByaUIwOWJObU5TK21ibmR6OEY0V3FPVU1Q?=
 =?utf-8?B?UWMycXJ2dTlUNHNtc3RUY0JKb0lzdUdzRW96UEJvL1JMSU5BbXE1TDEyK01G?=
 =?utf-8?B?RUVHYmlwWm1MdmNZUTdGY1FvZWs1bGN2aEoxNnNSSGFFdkR4Wk5HbHhYUUth?=
 =?utf-8?B?RDRBRUZXWnBQbktvY3pLbEREVGVCditpa0oxY3BjY09mQWtzNVlMdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83261C71C1AFE74991AC2EB3BF058B0A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a604f73b-49c3-495d-19f5-08da41a9445a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2022 19:27:27.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P01wGwXELPIXARxIaXxDzqHGhbQOU7FG8c2HMaUONZ30LbQnJ5V+A9rk/JKyG4vYZlhOxWkBF5n4LGBv5UrN9KBVaiiYhUKmkGhlfdPv4O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3076
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCk9uIDI5LzA1LzIwMjIgMTk6NTEsIEl2YW4gQm9ybnlha292IHdyb3RlOg0KPiBPbiBTdW4s
IE1heSAyOSwgMjAyMiBhdCAwMTowMzoxMFBNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IE9uIDI5LzA1LzIwMjIgMTM6MzksIFh1IFlpbHVuIHdyb3RlOg0KPj4+
IE9uIFRodSwgTWF5IDI2LCAyMDIyIGF0IDA5OjEzOjQzUE0gKzAzMDAsIEl2YW4gQm9ybnlha292
IHdyb3RlOg0KPj4+PiBBZGQgc3VwcG9ydCB0byB0aGUgRlBHQSBtYW5hZ2VyIGZvciBwcm9ncmFt
bWluZyBNaWNyb2NoaXAgUG9sYXJmaXJlDQo+Pj4+IEZQR0FzIG92ZXIgc2xhdmUgU1BJIGludGVy
ZmFjZSB3aXRoIC5kYXQgZm9ybWF0dGVkIGJpdHNyZWFtIGltYWdlLg0KPj4+DQo+Pj4gRnJvbSBw
cmV2aW91cyBtYWlsIHRocmVhZCwgdGhlcmUgYXJlIHN0aWxsIHNvbWUgaGFyZHdhcmUgb3BlcmF0
aW9ucyB5ZXQNCj4+PiB0byBiZSBjbGFyaWZpZWQsIHNvIEkgbWF5IG5lZWQgYSBSZXZpZXdlZC1i
eSBmcm9tIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tLg0KPj4NCj4+IFllYWgsIHdhcyByZWFs
bHkgYnVzeSBsYXN0IHdlZWsuIFBsYW5uaW5nIG9uIGdpdmluZyB0aGlzIHZlcnNpb24gYSBnbw0K
Pj4gdG9tb3Jyb3cuIEkgKnRoaW5rKiBJIGV4cGxhaW5lZCB0aGUgcmVhc29uIHRoZSBzdGF0dXMg
Y2hlY2sgbmVlZGVkIHRvIGJlIGENCj4+IHN5bmNfdHJhbnNmZXIoKSBidXQgaXQgaGFzbid0IGJl
ZW4gcmVmbGVjdGVkIGluIGEgY29tbWVudCB5ZXQuDQo+Pg0KPj4gSSBkaWRuJ3Qga25vdyB0aGUg
YW5zd2VycyB0byB0aGUgdHdvIG90aGVyIHF1ZXN0aW9ucyAmIHBhc3NlZCB0aGVtIG9uIHRvIHRo
ZQ0KPj4gZGVzaWduZXJzIG9mIHRoZSBoYXJkd2FyZSBibG9ja3MgLSBidXQgYm90aCBhcmUgdHJh
dmVsaW5nIHNvIG5vdCBnb3QgYQ0KPj4gcmVzcG9uc2UgeWV0LiBUaGVyZSdzIG9uZSBiaXQgb2Yg
Y2xhcmlmaWNhdGlvbiBJJ2QgbGlrZSBmcm9tIHlvdXI6DQo+Pg0KPj4+Pj4gK3N0YXRpYyBpbnQg
bXBmX29wc193cml0ZShzdHJ1Y3QgZnBnYV9tYW5hZ2VyICptZ3IsIGNvbnN0IGNoYXIgKmJ1Ziwg
c2l6ZV90IGNvdW50KQ0KPj4+Pj4gK3sNCj4+Pj4+ICsJdTggdG1wX2J1ZltNUEZfU1BJX0ZSQU1F
X1NJWkUgKyAxXSA9IHsgTVBGX1NQSV9GUkFNRSwgfTsNCj4+Pj4+ICsJc3RydWN0IG1wZl9wcml2
ICpwcml2ID0gbWdyLT5wcml2Ow0KPj4+Pj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmbWdyLT5k
ZXY7DQo+Pj4+PiArCXN0cnVjdCBzcGlfZGV2aWNlICpzcGk7DQo+Pj4+PiArCWludCByZXQsIGk7
DQo+Pj4+PiArDQo+Pj4+PiArCWlmIChjb3VudCAlIE1QRl9TUElfRlJBTUVfU0laRSkgew0KPj4+
Pj4gKwkJZGV2X2VycihkZXYsICJCaXRzdHJlYW0gc2l6ZSBpcyBub3QgYSBtdWx0aXBsZSBvZiAl
ZFxuIiwNCj4+Pj4+ICsJCQlNUEZfU1BJX0ZSQU1FX1NJWkUpOw0KPj4+Pj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+Pj4+PiArCX0NCj4+Pj4+ICsNCj4+Pj4+ICsJc3BpID0gcHJpdi0+c3BpOw0KPj4+
Pj4gKw0KPj4+Pj4gKwlmb3IgKGkgPSAwOyBpIDwgY291bnQgLyBNUEZfU1BJX0ZSQU1FX1NJWkU7
IGkrKykgew0KPj4+Pj4gKwkJbWVtY3B5KHRtcF9idWYgKyAxLCBidWYgKyBpICogTVBGX1NQSV9G
UkFNRV9TSVpFLA0KPj4+Pj4gKwkJICAgICAgIE1QRl9TUElfRlJBTUVfU0laRSk7DQo+Pj4+PiAr
DQo+Pj4+PiArCQlyZXQgPSBtcGZfc3BpX3dyaXRlKHNwaSwgdG1wX2J1Ziwgc2l6ZW9mKHRtcF9i
dWYpKTsNCj4+Pj4NCj4+Pj4gQXMgSSBtZW50aW9uZWQgYmVmb3JlLCBpcyBpdCBwb3NzaWJsZSB3
ZSB1c2Ugc3BpX3N5bmNfdHJhbnNmZXIgdG8gYXZvaWQNCj4+Pj4gbWVtY3B5IHRoZSB3aG9sZSBi
aXRzdHJlYW0/DQo+Pj4NCj4+PiBVbmZvcnR1bmF0ZWx5LCBJIGRpZG4ndCBzdWNjZWVkIHdpdGgg
c3BpX3N1bmNfdHJhbnNmZXIgaGVyZS4gTWF5IGJlDQo+Pj4gQ29ub3Igb3Igb3RoZXIgZm9sa3Mg
d2l0aCBtb3JlIGluc2lnaHQgb24gTWljcm9jaGlwJ3MgSFcgd291bGQgYmUgYWJsZQ0KPj4+IHRv
IGVsaW1pbmF0ZSB0aGlzIG1lbWNweS4uLg0KPj4NCj4+IEkgdW5kZXJzdG9vZCB0aGlzIGFzIGJl
aW5nIGEgcXVlc3Rpb24gYWJvdXQgd2h5IGl0IHdhcyByZXF1aXJlZCB0byBjaGVjaw0KPj4gdGhl
IHN0YXR1cyBvZiB0aGUgaGFyZHdhcmUgYmV0d2VlbiBmcmFtZXMgb2YgdGhlIGJpdHN0cmVhbSBy
YXRoZXIgdGhhbg0KPj4gdXNpbmcgc3BpX3N5bmNfdHJhbnNmZXIoKSB0byBjb3B5IGVhY2ggZnJh
bWUgYmFjayB0byBiYWNrLg0KPj4NCj4+IElzIHRoYXQgY29ycmVjdD8NCj4gDQo+IE5vLg0KPiBU
aGUgaXNzdWUgaGVyZSBpcyBtZW1jcHkoKSBhIGJpdHN0cmVhbSBkYXRhIGZyYW1lIHRvIHRlbXBv
cmFyeSBidWZmZXINCj4gYmVmb3JlIHNlbmRpbmcgaXQgdG8gdGhlIGRldmljZS4NCj4gVGhlIHJl
YXNvbiBmb3IgbWVtY3B5KCkgaXMgdGhhdCB3ZSBuZWVkIHRvIHNlbmQgdG8gdGhlIGRldmljZSAx
NyBieXRlczoNCj4gMXN0IGJ5dGUgMHhFRSBhbmQgbmV4dCAxNiBieXRlcyAtIGJpdHN0cmVhbSBk
YXRhLg0KPiBQb3NzaWJsZSBzb2x1dGlvbiB0byBlbGltaW5hdGUgbWVtY3B5KCkgaXMgdG8gdXNl
IHNwaV9zeW5jX3RyYW5zZmVyKCkNCj4gaW5zdGVhZCBvZiBzcGlfd3JpdGUoKSBmb3Igc2VuZGlu
ZyBiaXRzdHJlYW0gZnJhbWVzLCBsaWtlIHNvOg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZnBnYS9taWNyb2NoaXAtc3BpLmMgYi9kcml2ZXJzL2ZwZ2EvbWljcm9jaGlwLXNwaS5jDQo+IGlu
ZGV4IDc1NzliMGRlMTE5Zi4uYmY2MmVlN2ZkNjMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zw
Z2EvbWljcm9jaGlwLXNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZnBnYS9taWNyb2NoaXAtc3BpLmMN
Cj4gQEAgLTI3MCw3ICsyNzAsOCBAQCBzdGF0aWMgaW50IG1wZl9vcHNfd3JpdGVfaW5pdChzdHJ1
Y3QgZnBnYV9tYW5hZ2VyICptZ3IsDQo+IA0KPiAgc3RhdGljIGludCBtcGZfb3BzX3dyaXRlKHN0
cnVjdCBmcGdhX21hbmFnZXIgKm1nciwgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQo+
ICB7DQo+IC0gICAgICAgdTggdG1wX2J1ZltNUEZfU1BJX0ZSQU1FX1NJWkUgKyAxXSA9IHsgTVBG
X1NQSV9GUkFNRSwgfTsNCj4gKyAgICAgICB1OCBzcGlfZnJhbWVfY29tbWFuZCA9IE1QRl9TUElf
RlJBTUU7DQo+ICsgICAgICAgc3RydWN0IHNwaV90cmFuc2ZlciB4ZmVyc1syXSA9IHsgMCB9Ow0K
PiAgICAgICAgIHN0cnVjdCBtcGZfcHJpdiAqcHJpdiA9IG1nci0+cHJpdjsNCj4gICAgICAgICBz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmbWdyLT5kZXY7DQo+ICAgICAgICAgc3RydWN0IHNwaV9kZXZp
Y2UgKnNwaTsNCj4gQEAgLTI4NSwxMCArMjg2LDE1IEBAIHN0YXRpYyBpbnQgbXBmX29wc193cml0
ZShzdHJ1Y3QgZnBnYV9tYW5hZ2VyICptZ3IsIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50
DQo+ICAgICAgICAgc3BpID0gcHJpdi0+c3BpOw0KPiANCj4gICAgICAgICBmb3IgKGkgPSAwOyBp
IDwgY291bnQgLyBNUEZfU1BJX0ZSQU1FX1NJWkU7IGkrKykgew0KPiAtICAgICAgICAgICAgICAg
bWVtY3B5KHRtcF9idWYgKyAxLCBidWYgKyBpICogTVBGX1NQSV9GUkFNRV9TSVpFLA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgIE1QRl9TUElfRlJBTUVfU0laRSk7DQo+ICsgICAgICAgICAgICAg
ICB4ZmVyc1swXS50eF9idWYgPSAmc3BpX2ZyYW1lX2NvbW1hbmQ7DQo+ICsgICAgICAgICAgICAg
ICB4ZmVyc1swXS5sZW4gPSAxOw0KPiArICAgICAgICAgICAgICAgeGZlcnNbMV0udHhfYnVmID0g
YnVmICsgaSAqIE1QRl9TUElfRlJBTUVfU0laRTsNCj4gKyAgICAgICAgICAgICAgIHhmZXJzWzFd
LmxlbiA9IE1QRl9TUElfRlJBTUVfU0laRTsNCj4gKw0KPiArICAgICAgICAgICAgICAgcmV0ID0g
bXBmX3BvbGxfc3RhdHVzKHNwaSwgMCk7DQo+ICsgICAgICAgICAgICAgICBpZiAocmV0ID49IDAp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHNwaV9zeW5jX3RyYW5zZmVyKHNwaSwg
eGZlcnMsIDIpOw0KPiANCj4gLSAgICAgICAgICAgICAgIHJldCA9IG1wZl9zcGlfd3JpdGUoc3Bp
LCB0bXBfYnVmLCBzaXplb2YodG1wX2J1ZikpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHJldCkg
ew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byB3cml0
ZSBiaXRzdHJlYW0gZnJhbWUgJWQvJXp1XG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGksIGNvdW50IC8gTVBGX1NQSV9GUkFNRV9TSVpFKTsNCj4gDQo+IE5vdGUgdGhhdCB0
aGlzIGlzIG5vdCBhIHdvcmtpbmcgc29sdXRpb24uDQoNCkhtbSwgSSdsbCB0YWtlIGEgbG9vayBh
Z2Fpbi4gSSBkaWQgcXVpY2tseSBkbyBzb21ldGhpbmcgbGlrZSB0aGlzDQpsYXN0IE1vbmRheSB3
aGVuIEkgd2FzIHRyeWluZyB0byBmaWd1cmUgb3V0IHdoYXQgd2FzIG1lYW50LCBidXQgSQ0Kb21p
dHRlZCB0aGUgbXBmX3BvbGxfc3RhdHVzKCkgYW5kIHRoYXQgd2FzIGVub3VnaCB0byBzY3JldyBp
dCB1cC4NCkknbGwgdGFrZSBhbm90aGVyIGxvb2sgdy8gdGhpcyBzbmlwcGV0Lg0KVGhhbmtzLA0K
Q29ub3IuDQo=
