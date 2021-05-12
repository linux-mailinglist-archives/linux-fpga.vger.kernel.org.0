Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0137BCC0
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhELMqp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 08:46:45 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:54560
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233240AbhELMqp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 May 2021 08:46:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckp66IG39ze4X0m5oLACFnR4rf0IHAK9pcydBvgZ1apg+LCLrjcIJU0BY7qXsA9b8sVCOLzrKtB5XsNLjjX0aLwsbKuOx/O8m8oqyo1CTKNGF3f4Ur+4XaRS7iq6GKdXwDl7cycMCDazhjEf+UQF393M3V5VR7R4tsHklz+DFBZv8ESJGxTXoJ/GGE/Q8m8BVOddja8hYLupNG8wSbmuDtE6ICl/j2OjWURS/7nIfgLuMrOKwMj1qO1yWTKpUj2yecE4SNwFIu9nkXIXK0b0oPhPUSF6tOubUDG90emKNjBLcVIawwUT9JMhxpBdWQQeRXsX/+zQWgCQMeembBc6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+KpEgOJjyraYTrOiuS8ppMwzNYDvs9yyLyjZziaY8s=;
 b=YjEa9nQ+6sNSERM+RcJ8aM7yNO3jm9B/5hMdUvpD9S/4A5jcMHi1+CY5jJOJgHetGOLwkVzJBTZ7PR5UmaBFC52UY+3g/kic+ZN3NAG+k4g86oPTdWkmv2ZFvNxgtmghomD3Wi8wmbRLeyBiVkoy+OGXVod0DTDcgZ3GIJdH53HJZRV/ByKuFIZwwsRcVSOEDli5M3AOJgFURv0JlrYDWGulzgHMERAaJ9NzHxoltpN38VUGXPHVUY+d4qdWVgm6jpKRYS4UBowq9KyjO5piaVWlst0V1csUxiqk1RCfD81ml8/iN3ysXlczfsNNQqF8enNwfmKujltkZ8O0EMvEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+KpEgOJjyraYTrOiuS8ppMwzNYDvs9yyLyjZziaY8s=;
 b=ctqJmmcFl0orYKqZG8eA7e+skUsHmJP7HaS7PlytuOg+JX9T4VKN1ErN7fAfk2FG/HDEJwoYaT9SeO4fJmpME24HaIyghC/9chEmLeaiGYwInCBYIg5xgDEmVl5YCdGSTDTEfzO061TIOzD4HRNqahCrp7k3+VK1rG+8n3JuvYs=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR0201MB3563.namprd02.prod.outlook.com (2603:10b6:301:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Wed, 12 May
 2021 12:45:28 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4129.025; Wed, 12 May 2021
 12:45:27 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>
Subject: RE: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Topic: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Index: AQHXPQErV0G7SQw9VkmmikpPIEZooarNdzQAgAWeuSCAAEZEgIAMgrIQ
Date:   Wed, 12 May 2021 12:45:27 +0000
Message-ID: <MWHPR02MB262398EA9D520A9DEB4637A3C2529@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
 <20210429140408.23194-2-nava.manne@xilinx.com>
 <20210430194000.GA3742101@robh.at.kernel.org>
 <MWHPR02MB262372B79B43EC798C06F491C25A9@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CAL_Jsq+pVg-wZAccCVrfSeDygpb80Z28Ke9TOJxNPeyUMWvLdA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+pVg-wZAccCVrfSeDygpb80Z28Ke9TOJxNPeyUMWvLdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c507986f-b236-4d74-912f-08d91543d1fd
x-ms-traffictypediagnostic: MWHPR0201MB3563:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB356310827E3F32EF6E2D6358C2529@MWHPR0201MB3563.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/twTkfyoNK5EJU0n0btBz6KXrxg0KE0Z46oO8bCJsZALvAZRzlNDfIXPzgnW8BE5EfEVI/2syHsn5mF3P23KrWEeQ1X81OVM6xmFTQvnAeJmp2TDKSn9jWJEqt+r91WUOZ+NslD2g5OZbjsj4DyyVG/oefobuGxHMwt2kw4xJCTmZGpt3YUA0iQSbBt8I9Qfbj/oLN+yphzjC5DRugMy3GOhoJpJHPtOz5t7q31NaHO4kY2/ga8Cs18PDob3u0MG0MNbuY0hfarsBAue21r5QDqHuiY+mRNjpOgeXAtrFHTDAvQwJ1AM2/nJxRm+0VFrK3BPgtt3zUmgZJSApFfj++G5bnk1McH5bnVUJodx20Zh1jPLcjODQbdShxR+tVFJWfKWSdVpsvFNjdL3dZHJDyc73Z/9Rh88w++uhb/irNxmx12V7Aa3OMJ28buEOuPv96x0LKKUCKR5Rej6xUfSb6V+eERpa53/B/U1ol9FmyZofxziuJEnwXkJL10K93mj0nLunqXvBZytktU7P752XFYX44Lg+KJ0VMzkupO0lyuY5QKH/XqYAviSgu9++v4n2Pk3+AFokQ/o+pZ+FWAZYX1BgrYUSvjwO78Yt93vSLpXAmunmIStVbFoZ8SVSKLNQeQHqAzNX6O6xojLI6Q0PeGvXNauQGkxuW1ARFp1TkRulKlaOOQXLf7cOBXUVMlESMoRB191+CuVXX8xyGQH+jCZVGH/D/2q/vkZY2sXnQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(186003)(7696005)(71200400001)(8676002)(316002)(7416002)(33656002)(6506007)(478600001)(53546011)(4326008)(86362001)(2906002)(55016002)(76116006)(6916009)(5660300002)(107886003)(8936002)(9686003)(122000001)(26005)(38100700002)(52536014)(966005)(64756008)(66476007)(66946007)(83380400001)(66446008)(66556008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGUvMW1jNG5KSnBscE9YRjRtYkcwa084RDJSWUt3b3h5R0V2dFg1Z2w2N250?=
 =?utf-8?B?YzlQZUxUQ0xPeCtZeFM3d2thVTZDYUM5Y3ZZUUl0VTNVRXlERTZLNXg4aWQx?=
 =?utf-8?B?L2lrVWpUcnMyZXpJWXM0aDNqYmNwTEJDQTEzTWUvQ3UxSEMyS3RhSjJhVVNO?=
 =?utf-8?B?RHlCZjllR0N4V0N0VjdTY3E1YlBuVXY2T3lOZ3VDS2dzZmluMGNUdzhXeHJu?=
 =?utf-8?B?SW42czY3bHU0NFg0QTJSbERIa05RaUk0SXVSNGhMMmZuNCtoN25ObFdwQmpX?=
 =?utf-8?B?WEdLY1YyWVZGZU5veTBXamRxNms2WlZZVDdXMlllTHZGb0dpeEU3cGhHSnRD?=
 =?utf-8?B?VTB3UER5TEVGeFRJVW56UmMzY3lZeVFLQktCVzNVZFlFMXoxam15K3hvTTFi?=
 =?utf-8?B?L3NYT044UEFtTDlDUGpnYW1XQVFyWnUwcTZNaWlzeWl4aDdGUFBodGliZnJF?=
 =?utf-8?B?SzErVUJ1MUpNYm1HSnBaNGlOcWJsR1JMdGRnb2V2QkFwTGE3VDhxMS9Ia1pp?=
 =?utf-8?B?RzRwTlRuRm5GWXBCbmc1QUMrb1gxajB6L3dvQnNiQXNXV3g0WjFLWXBURTRJ?=
 =?utf-8?B?aHpDT3doYURxUi9BdytuSUpWQkZMSmhMQzUzRkgyb1pXWE92M09ac0FjZis1?=
 =?utf-8?B?THNRWmFrTnlmT3hWeG9pa0NOblBtZDBKQzNOTGdoMndzK0lMZ1BKaS9WT2dB?=
 =?utf-8?B?dllzY2sxR2xhQ1kzUTYxNi8yNnN0UnpqVzJwVkErTTRLQVFxTWprMnhRSUFh?=
 =?utf-8?B?RjM4UkYwd1J4ckZHVngzcDBPM05Vejh6Q1c1VmROaDJ5ck1Oc09hbmZHUzVU?=
 =?utf-8?B?YzY5SXdlNTdOQm9QTVcxbHZ6Wk9ydUMzZExQd1Zab1UrUmFvMk5CYmRZTnJw?=
 =?utf-8?B?ancwZC9nVkg0WWxWenJTbEtkTFpHT0E1TVpZeTVURGVzQzh1SzYvM2lvYm9E?=
 =?utf-8?B?b0htNHhYL1NoWEpxRjhiQ2xMZExZS25FNWQyME9YNzVIUDFXeDVHL1R2enZR?=
 =?utf-8?B?bm43eGJJMUFYdFo1RmowQ3M1THhFUHFjREJ4MUJ2cTByNEVJeTZqU1ZySGIx?=
 =?utf-8?B?NnJWcGhlYTI0MVJVQ0Q0UFVNSnk3NXdLaHJYdThLK3N5b1FiQXRlTkFpSzRh?=
 =?utf-8?B?MVhWNzMzV2NLbnhjRCtnb3hJRXVaVERBVGo3akhYb1BrQmdxSFhvMlRWZ1BV?=
 =?utf-8?B?MFg2OElKdmphcElGbmJGeGdGRDJKWGVOR0JPbjdZWCtiWXUzV1A5R1kxY0lj?=
 =?utf-8?B?RTA0ZDUwOFhOWWozV1dEQjltMEtFcU9hT1FxUHo3U2xuTndUVzNWQ0t0U1NT?=
 =?utf-8?B?TGM1YVVBNVlrdFpUOXlRZWoycTJLQ2FqaXdXNXcyK25aS3RUTm8raWQ4RzdX?=
 =?utf-8?B?ekRBRnMxWXk4eDNSOGhBSHl1dVRmZ0MyZGdKa3IrNkp2YndPc3V0ZUFycmNI?=
 =?utf-8?B?N3MzZHhDem1zVTh3MzJrYVRyZTJOUDk5ZTNiOGpxbWljZjNNMzQvV3VuQ0FZ?=
 =?utf-8?B?ejZTMlhuL2syUWE3bUlxRW1ZV1h0Um1iNUZJY1JkbjA4RWY0emt5c0QxZXp4?=
 =?utf-8?B?SlVBSDdBY0VoQVJGY3N0RXBWaHM5cW1JTnRQd1c0WkI2U1J0ZWMwVW05ZGZQ?=
 =?utf-8?B?N0M4RGFLL3psYVo1V0crY2JiRldUcG1ieWgxSkR4TVRqQWpuMUhadmRGRHYw?=
 =?utf-8?B?MGxLd3lGbEhBRVhkaDR3YUREYlZ2ZFl0V3c5OUhhaTJVeFhKYUllSjVtQVU4?=
 =?utf-8?Q?kHrJCvonJVobg25+TV7WNn7g4ro/8cbo1ePIt5v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c507986f-b236-4d74-912f-08d91543d1fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 12:45:27.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voFHEl2ncAF3xGDfN6ui4uZBLsAZ1XtBydxMpKAsMp1fW/2iikRVvELVGIe9nPeG1C3wGRCfHXlOh30ITAzE0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3563
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgUm9iLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSA0LCAyMDIxIDc6MTEgUE0NCj4gVG86IE5hdmEga2lzaG9y
ZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT4NCj4gQ2M6IE1pY2hhbCBTaW1layA8bWljaGFsc0B4
aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmc7IHRyaXhAcmVkaGF0LmNvbTsNCj4gZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc7IGFybmRAYXJuZGIuZGU7IFJhamFuIFZhamENCj4gPFJBSkFOVkB4
aWxpbnguY29tPjsgQW1pdCBTdW5pbCBEaGFtbmUgPGFtaXRzdW5pQHhsbngueGlsaW54LmNvbT47
DQo+IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT47IHpvdV93ZWlAaHVhd2VpLmNv
bTsgU2FpIEtyaXNobmENCj4gUG90dGh1cmkgPGxha3NobWlzQHhpbGlueC5jb20+OyBpd2FtYXRz
dUBuaWdhdXJpLm9yZzsgSmlheWluZyBMaWFuZw0KPiA8amxpYW5nQHhpbGlueC5jb20+OyBsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBmcGdhQHZnZXIua2VybmVsLm9yZzsgY2hpbm5pa2lzaG9yZTM2OUBn
bWFpbC5jb207IGdpdCA8Z2l0QHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQg
MS80XSBkdC1iaW5kaW5nczogZmlybXdhcmU6IEFkZCBiaW5kaW5ncyBmb3IgeGlsaW54DQo+IGZp
cm13YXJlDQo+IA0KPiBPbiBUdWUsIE1heSA0LCAyMDIxIGF0IDQ6MzQgQU0gTmF2YSBraXNob3Jl
IE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpIFJvYiwNCj4g
Pg0KPiA+ICAgICAgICAgUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KPiA+DQo+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMSwgMjAyMSAxOjEwIEFN
DQo+ID4gPiBUbzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPg0KPiA+ID4g
Q2M6IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmc7DQo+
ID4gPiB0cml4QHJlZGhhdC5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBhcm5kQGFy
bmRiLmRlOyBSYWphbg0KPiA+ID4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBBbWl0IFN1bmls
IERoYW1uZQ0KPiA+ID4gPGFtaXRzdW5pQHhsbngueGlsaW54LmNvbT47IE1hbmlzaCBOYXJhbmkg
PE1OQVJBTklAeGlsaW54LmNvbT47DQo+ID4gPiB6b3Vfd2VpQGh1YXdlaS5jb207IFNhaSBLcmlz
aG5hIFBvdHRodXJpIDxsYWtzaG1pc0B4aWxpbnguY29tPjsNCj4gPiA+IGl3YW1hdHN1QG5pZ2F1
cmkub3JnOyBKaWF5aW5nIExpYW5nIDxqbGlhbmdAeGlsaW54LmNvbT47DQo+ID4gPiBsaW51cy53
YWxsZWlqQGxpbmFyby5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiA+ID4gbGludXgtIGZwZ2FAdmdlci5rZXJuZWwub3JnOyBjaGlubmlraXNob3Jl
MzY5QGdtYWlsLmNvbTsgZ2l0DQo+ID4gPiA8Z2l0QHhpbGlueC5jb20+DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY0IDEvNF0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBBZGQgYmluZGluZ3Mg
Zm9yDQo+ID4gPiB4aWxpbnggZmlybXdhcmUNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEFwciAyOSwg
MjAyMSBhdCAwNzozNDowNVBNICswNTMwLCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4g
PiA+IEFkZCBkb2N1bWVudGF0aW9uIHRvIGRlc2NyaWJlIFhpbGlueCBmaXJtd2FyZSBkcml2ZXIg
YmluZGluZ3MuDQo+ID4gPiA+IEZpcm13YXJlIGRyaXZlciBwcm92aWRlcyBhbiBpbnRlcmZhY2Ug
dG8gZmlybXdhcmUgQVBJcy4NCj4gPiA+ID4gSW50ZXJmYWNlIEFQSXMgY2FuIGJlIHVzZWQgYnkg
YW55IGRyaXZlciB0byBjb21tdW5pY2F0ZSB0bw0KPiA+ID4gPiBQbGF0Zm9ybSBNYW5hZ2VtZW50
IFVuaXQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE5hdmEga2lzaG9yZSBNYW5u
ZSA8bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gQ2hhbmdlcyBm
b3IgdjQ6DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAtQWRkZWQgbmV3IHlhbWwgZmlsZSBmb3Ig
eGlsaW54IGZpcm13YXJlDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgYXMgc3VnZ2VzdGVkIGJ5
IFJvYi4NCj4gPiA+ID4NCj4gPiA+ID4gIC4uLi9maXJtd2FyZS94aWxpbngveGxueCx6eW5xbXAt
ZmlybXdhcmUueWFtbCB8IDYzDQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJl
L3hpbGlueC94bG54LHp5bnFtcC0NCj4gPiA+IGZpcm13YXJlDQo+ID4gPiA+IC55YW1sDQo+ID4g
Pg0KPiA+ID4gV2hhdCBhYm91dCB0aGUgb2xkIGRvYz86DQo+ID4gPg0KPiA+DQo+ID4gQXMgeW91
IHN1Z2dlc3RlZCBpIGhhdmUgYWRkZWQgb25seSB0aGUgZnBnYSBub2RlIHJlbGV2YW50IGluZm8g
aGVyZSBzbyBpdCdzDQo+IG5vdCByZXByZXNlbnRpbmcgdGhlIGNvbXBsZXRlIGZpcm13YXJlIGZp
bGUgd2l0aCBvdGhlciBzdWIgbm9kZSBsaWtlIGNsaywgQWVzLA0KPiAuLi5ldGMuDQo+ID4gT25j
ZSBpdCBjb21wbGV0ZWx5IG1hdHVyZSB3ZSBjYW4gZGVwcmVjYXRlIHRoZSBPbGQgZG9jLg0KPiA+
DQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUveGlsaW54
L3hsbngsenlucW1wLQ0KPiA+ID4gZmlybXdhcmUudHh0DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4g
PiBkaWZmIC0tZ2l0DQo+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC0NCj4gPiA+IGZpcm13YQ0KPiA+ID4gPiByZS55
YW1sDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJl
L3hpbGlueC94bG54LHp5bnFtcC0NCj4gPiA+IGZpcm13YQ0KPiA+ID4gPiByZS55YW1sDQo+ID4g
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNGI5
N2YwMDViZWQ3DQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtDQo+ID4g
PiA+ICsrKyBwLWZpDQo+ID4gPiA+ICsrKyBybXdhcmUueWFtbA0KPiA+ID4gPiBAQCAtMCwwICsx
LDYzIEBADQo+ID4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5
IE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwNCj4gPiA+ID4gKzEuMg0KPiA+ID4gPiArLS0tDQo+ID4g
PiA+ICskaWQ6DQo+ID4gPiA+ICtodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9maXJtd2Fy
ZS94aWxpbngveGxueCx6eW5xbXAtZmlybXdhcg0KPiA+ID4gPiArZS55YQ0KPiA+ID4gPiArbWwj
DQo+ID4gPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4gPiA+ID4gKw0KPiA+ID4gPiArdGl0bGU6IFhpbGlueCBmaXJtd2FyZSBkcml2
ZXINCj4gPiA+ID4gKw0KPiA+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiA+ICsgIC0gTmF2YSBr
aXNob3JlIE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+DQo+ID4gPiA+ICsNCj4gPiA+ID4g
K2Rlc2NyaXB0aW9uOg0KPiA+ID4gPiArICBUaGUgenlucW1wLWZpcm13YXJlIG5vZGUgZGVzY3Jp
YmVzIHRoZSBpbnRlcmZhY2UgdG8gcGxhdGZvcm0NCj4gPiA+IGZpcm13YXJlLg0KPiA+ID4gPiAr
ICBaeW5xTVAgaGFzIGFuIGludGVyZmFjZSB0byBjb21tdW5pY2F0ZSB3aXRoIHNlY3VyZSBmaXJt
d2FyZS4NCj4gPiA+ID4gK0Zpcm13YXJlDQo+ID4gPiA+ICsgIGRyaXZlciBwcm92aWRlcyBhbiBp
bnRlcmZhY2UgdG8gZmlybXdhcmUgQVBJcy4gSW50ZXJmYWNlIEFQSXMNCj4gPiA+ID4gK2NhbiBi
ZQ0KPiA+ID4gPiArICB1c2VkIGJ5IGFueSBkcml2ZXIgdG8gY29tbXVuaWNhdGUgdG8gUE1VRlco
UGxhdGZvcm0NCj4gTWFuYWdlbWVudA0KPiA+ID4gVW5pdCkuDQo+ID4gPiA+ICsgIFRoZXNlIHJl
cXVlc3RzIGluY2x1ZGUgY2xvY2sgbWFuYWdlbWVudCwgcGluIGNvbnRyb2wsIGRldmljZQ0KPiA+
ID4gPiArY29udHJvbCwNCj4gPiA+ID4gKyAgcG93ZXIgbWFuYWdlbWVudCBzZXJ2aWNlLCBGUEdB
IHNlcnZpY2UgYW5kIG90aGVyIHBsYXRmb3JtDQo+ID4gPiA+ICttYW5hZ2VtZW50DQo+ID4gPiA+
ICsgIHNlcnZpY2VzLg0KPiA+ID4gPiArDQo+ID4gPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ID4gPiAr
ICBjb21wYXRpYmxlOg0KPiA+ID4gPiArICAgIG9uZU9mOg0KPiA+ID4gPiArICAgICAgLSBkZXNj
cmlwdGlvbjoNCj4gPiA+ID4gKyAgICAgICAgICBGb3IgaW1wbGVtZW50YXRpb25zIGNvbXBseWlu
ZyBmb3IgWnlucSBVbHRyYXNjYWxlKyBNUFNvQy4NCj4gPiA+ID4gKyAgICAgICAgY29uc3Q6IHhs
bngsenlucW1wLWZpcm13YXJlDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgIC0gZGVzY3JpcHRp
b246DQo+ID4gPiA+ICsgICAgICAgICAgRm9yIGltcGxlbWVudGF0aW9ucyBjb21wbHlpbmcgZm9y
IFZlcnNhbC4NCj4gPiA+ID4gKyAgICAgICAgY29uc3Q6IHhsbngsdmVyc2FsLWZpcm13YXJlDQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgbWV0aG9kOg0KPiA+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBU
aGUgbWV0aG9kIG9mIGNhbGxpbmcgdGhlIFBNLUFQSSBmaXJtd2FyZSBsYXllci4NCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAjICBQZXJtaXR0ZWQgdmFsdWVzIGFyZToNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAjICAtICJzbWMiIDogU01DICMwLCBmb2xsb3dpbmcgdGhlIFNNQ0NDDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICAgIyAgLSAiaHZjIiA6IEhWQyAjMCwgZm9sbG93aW5nIHRoZSBT
TUNDQw0KPiA+ID4NCj4gPiA+IERyb3AgdGhlICcjJy4gSWYgeW91IHdhbnQgdG8gbWFpbnRhaW4g
dGhlIGZvcm1hdHRpbmcsIHRoZW4gdXNlICd8Jw0KPiA+ID4gYWZ0ZXIgJ2Rlc2NyaXB0aW9uOicg
Zm9yIGEgbGl0ZXJhbCBibG9jay4NCj4gPiA+DQo+ID4NCj4gPiBXaWxsIGZpeCBpbiB2NS4NCj4g
Pg0KPiA+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0
cmluZy1hcnJheQ0KPiA+ID4gPiArICAgIGVudW06DQo+ID4gPiA+ICsgICAgICAtIHNtYw0KPiA+
ID4gPiArICAgICAgLSBodmMNCj4gPiA+ID4gKw0KPiA+ID4gPiArcGF0dGVyblByb3BlcnRpZXM6
DQo+ID4gPiA+ICsgICJmcGdhIjoNCj4gPiA+DQo+ID4gPiBTbyAnZm9vZnBnYWJhcicgaXMgdmFs
aWQ/DQo+ID4gPg0KPiA+DQo+ID4gWWVzLCBpdCdzIGEgdmFsaWQgZm9yIGZwZ2Egbm9kZS4NCj4g
DQo+IE5vLCBwbGVhc2UgbWFrZSB0aGUgbm9kZSBuYW1lIG1vcmUgc3BlY2lmaWMuDQo+IA0KDQpX
aWxsIGZpeCBpbiB2NS4NCg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0K
