Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7C5A5B38
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 07:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiH3FlS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 01:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH3FlQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 01:41:16 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9199CCFE;
        Mon, 29 Aug 2022 22:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVJ2ESxO8RqTV8hHbu78onIwT/HA2czjEwV+LuHlsQRWT8KRoy0FPAEfR7BncuLO386RD5vZFXjMtVgI8olGIA4ajjB1Tv32NyZYjzgDzj1kMTOqpHbTXvOUvjlYYHBbCtz8ulNLmEQBdgfE9NaPcSPN3BjOmveYQ1hiF0BaXWdAltDiocs76GCKrKN0anOhN+A8nw5tQ8zUuc9QwmtOkLL1WyVmkr5oHVOn7xAU/yRCasJsySsJ4erOKPIHSmnjab7vYKWh6V7rZRuCs8uprEf7PZn8QrrQeIpNrtPVfSuPM3ntLFLScXdtxUuKYxp5PITiWS8KoJuHsIZHCAVwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjCUIUAuC01wI08y+AAGreFr0mnHTHt2Gfm531tPz3I=;
 b=E4+f0y7bsWiwjqDYfArJxoXj7pqfNZXDZB/3cbnj/QcvzAddVRcM+tAmHwfsjU2bm1ohwi3BZZNCKalrw+izEoqAW2pKKMwotj2IfmV79NNfApqMChdPIsBUIVF+w8oC4MITdbczimUPfGJAce9zazta0ZMtb+swamHFG9njjY/o+ChUQGJxl2no6Os4RQ4xDnf4ZTVK7Ot3xFD04NYohGHUl1OAAxXBlSVnO6uItb3QiEtS3CsWTUdeJbackfmJ2QhLkW5sf7q045XsoN4qy2cjeLK/CbCI71m3YwjzC9RzbI0TtqFWc66rCpvAYiBb6WIzPmtjt5/OA+Q/ZL2g0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjCUIUAuC01wI08y+AAGreFr0mnHTHt2Gfm531tPz3I=;
 b=g6Ly2z0dvNkZpJcFAvIrPyuGSLviDZe2pUyKQ9LweduRvEU+I+gMvZzQQcAibOYZdHpZ6AHIXDOHTSXylvv4+v9SfskaLAbIrt40bybAY5YWXE/LZ+FDXh1TTGG7pGtPHWz3CD9Vfl/BInoMY/eMeYmzo/R4ZI9kGLr/04uAwmg=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by CY4PR12MB1688.namprd12.prod.outlook.com (2603:10b6:910:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 05:41:08 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 05:41:08 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH 3/4] bindings: firmware: Update binding doc for the zynqmp
 afi config node
Thread-Topic: [PATCH 3/4] bindings: firmware: Update binding doc for the
 zynqmp afi config node
Thread-Index: AQHYt215uFtAMg4eakyTkAsPpGOe7a2+A1CAgAjyC+A=
Date:   Tue, 30 Aug 2022 05:41:08 +0000
Message-ID: <DM6PR12MB3993B4525E7B5D00AFFC3565CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-4-nava.kishore.manne@amd.com>
 <09308102-f927-125e-4321-d231decbd6c9@linaro.org>
In-Reply-To: <09308102-f927-125e-4321-d231decbd6c9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80bd6b76-d270-465e-8e16-08da8a4a3d2b
x-ms-traffictypediagnostic: CY4PR12MB1688:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AsC/JSYK7kjfUA3KCuZR8vxQ8LswyK5ReZOWFBtcEZYCspmhtTf1jXnQqIXuFGnhLKZO8GuiVwWvJsgBjPPa+4OvtVA4jQ0TyRfMHzV+k4vkbzfQPWZeX3qxExsZ7R8FgPENefxnHeg4UH/kKnGNPK9HRS2jinzpQyJS4HNF5dNjZ0CzYlbz1HLpQ0K0ym2g55YKwT/us38Gz0ri5r7cPdK/rnCx0nnUIvi3e14T3V3e6UtxzR2Ti40mngojn91qCinaadc4kp1NaK208PslOEZAuThjx6a1sqMH1564fbLKhC2CKeOuXlhUxmreRlIN+CaSPLS4hM8gicV7RSTVrgJWucWe3ZLIlrM7xA/CrmFAijnnIm6TvZPawHCi01gyeNSOBNO5ye7cWpjFNlpjuTqr79LAMwY6IJ1GI/2zjPpL66Y+1rNK/e3cOY94CdORVg/yp3U5CT/niabPi1Bo8SW5DkL6sfUk4GfRf3m6tKahJsjvX4IN1BrjlK6cWwt/nIluSJ8SFU/1wIKwnQNQbZvXZz2M55N4Qeeb6a29g51zjq1du2fmpNcZPwg8FR7VAiGtYb8sWQapcBe3FupUwN8PaFZssC8LOIkqQw4tH1bw2lielJ09EUQMNAhPD8Uu99Pd6B9+6weBsw3H2/sdzSoDIiDf/YvPr2ijt2d5iU+e5gJfaF5GPxGZ6UgKjseAp7YBFOrT5Mna5LUcZRI7hAEI5Ow5/xyGRtczQ2dfJ7ZzT1Hj2RdT8oxToCNwZAWCzOAuJXxtOiwbyttliGBcdAJHhBZmxbya+yIzX2pn/2J3iaIQ6iPyVKAF0fe7ioH9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(8936002)(110136005)(8676002)(66446008)(66556008)(66946007)(66476007)(71200400001)(966005)(64756008)(316002)(76116006)(41300700001)(5660300002)(921005)(86362001)(38070700005)(478600001)(52536014)(7416002)(26005)(7696005)(15650500001)(53546011)(38100700002)(122000001)(6506007)(9686003)(55016003)(2906002)(83380400001)(33656002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHVkYUNtVFhWYitIY0FSaUQvT0FtbGRuUDVtMXNOZ3oyK1o1RjFCcHJTV1lm?=
 =?utf-8?B?bU9HUklhdXpGM2loUTE3SU0vZi8rTzNzN1ZtZndRS3JhWmxWdE9meEx0U1kr?=
 =?utf-8?B?RVA1bnFwa09NNnBISE9lSDdCMmxnbEhvWk9MVEladU5vSE8rWG9YZzJSNFlK?=
 =?utf-8?B?N2plVWh4UGZncXpqSXVYSENSeFh1T1k1ZXg4ekRqMnlRTXJyVCtVbU0zVWtB?=
 =?utf-8?B?eDJTZHhuVEJxdHA0a2JhZVpzd21uNmZQUDNld2JWTEttMnVZMWtqYjhTQ05Y?=
 =?utf-8?B?K3ZBcE9acUl4THdMUkdSNm1tYVB2RWFxaDRyZjZMbXlrc0RqSVhMRWNCY0J2?=
 =?utf-8?B?SGNFWTFOWnU2TmY3blNOb2U3Qnk5Mkh6SjhLWGc3Q1c4TFJKWFY5U00xSXhS?=
 =?utf-8?B?MzQ3bjFnVmU1SU84QzdNSW5UdUNJMy8wTlduZ1JiTDR0ZDN6TkpScU5FdjNC?=
 =?utf-8?B?OUNSUmxLc3BxcXNmcWR5ZnMxaTdCQlFDRGp0b0c4Y0hwbDJHMzd3NE1RaEF5?=
 =?utf-8?B?UWJiN1I2SHRFZ1BiQ0RjMXBOMEFVZS90VG10SXJWRUhpNG1ZNjd6SzF2Sklw?=
 =?utf-8?B?SnJNczNlbFNSUGRvc1R5a3lRS3JybTJGcllRLy83ZVJ1Qm5kc3pYci8yVEll?=
 =?utf-8?B?Vk5kRGtGQnExMFZ2S2pXTGdxVWx1alZuZ2xiaWs5RVJzUWczcm1sKzJnTXBp?=
 =?utf-8?B?N3l0Vk5TWW1PMVUvOWxCVXlKNHJNWkcxVDdnUzFnMmUvRlJnc2I4Y0oyK044?=
 =?utf-8?B?aFhnUFFWRHhoL0NoRjRLbHNQQXhnTzdiRG56K0RtK1Z1S3lIS0ZPbXJKZ3ow?=
 =?utf-8?B?UW54dGZkODcyYkRGWVZtci9nWkl6M2ZwY0tMRmVQVUp5NDFRNjZzV2llaDFz?=
 =?utf-8?B?ZEpLM3lqaWlCTmdOQ3NxK25sYmZ5K3FMV3BWL3pzSkp0K0dybm56MkFrNjIv?=
 =?utf-8?B?VVVEWU8wSS9rY2NMa2doSVF2Zm91NTVaN0hDaTd4NUU5MjZlUFZPcXBCRUZE?=
 =?utf-8?B?VE1FOXlUQTRkdUdOZXlUeG5MelVUMzR0ejlicEpUbG1lYmJYajFGMmU0WTY0?=
 =?utf-8?B?RGMwK1prd1dKcjRJb3oyZlpUd0dSZjd4QXluZVh6VW9VcmJZUjM4N1NsSERz?=
 =?utf-8?B?ZzlKTm0wUy9IY0ZnM3N2NEt0V0J2aXdxTjRHUlZNbnZsa2FtMXVsdjMwc012?=
 =?utf-8?B?aTBDTWIzT2FqaWlWd0h1OEZsUUZKbW1KQ1pyUGMzV05LSGFycTRTMlFWVExC?=
 =?utf-8?B?dkhJNVNQdjFZUmREMXIrekhzUG9JWWpzS3ptdHZ2Nk94SzFwOEV6U09KcFNw?=
 =?utf-8?B?a2tBWXRhSWVKWXdRQWlrWTB1M1lCU09oNnpGM0ZQOEE1VDFoWU1hZWJBelJa?=
 =?utf-8?B?RzhEUHA4c1MxQWo4aXdzOXNZUGRwMExnMnJ4Y0tFUnhpbUFNOFc2YnA0RzQ0?=
 =?utf-8?B?OTFlSUZOUmdTVE1zcGoyTU1HWUtsVENQbnRnMDcveUhhZ1ZXcUlzZ1c3L1RB?=
 =?utf-8?B?RzFQZ2VjazNVTkR2VGkyNUZjWm9mZmxMQ09PYmgzWlU3NkJFRlJHTVN6UTd4?=
 =?utf-8?B?aTZmUVFZMm9jSE5FT09EZ2dTY2RJV2Q0VC8vYjVJNDNNUVBnZUhmL2M0RDhr?=
 =?utf-8?B?eEVraEpLMkRBdjQyTERGQzd4Y2FQQW16T0ZPaU8ycTEwcHJLL0I1dDY5MVlt?=
 =?utf-8?B?d3lTbkJJQ3Z4UFVON0cyRHVOVDEvc2RiN0xMU1lrY1graE5yRnh0UEJZVDFY?=
 =?utf-8?B?R2pIVDlxdy9VbTltSkVxb3ZPcWYvYm1qMitjTmxycjlkL2JqMitGWkd0cTBm?=
 =?utf-8?B?L3o3dnR5Z1czRFRUTDByNG1GQm91OWZXMkVpMnZ0cUxFR3cwS0lJNTJQblF0?=
 =?utf-8?B?eCtMRHFFNGc2Mk1OR1JqaGcvSUVxM3NHemdFMEZyNVFJWS85ZVZHR3VNbWI5?=
 =?utf-8?B?WjdtT0ZpY1htR3FraDVtcnNtYXFLb0dGNjVtSnBtM0NubTVSSUpMMkpLL1d1?=
 =?utf-8?B?cjJ4RVNZeTI0eUM4Qk9GczJSY0s0T2NtUkdxNEN2YlVMSUpTT1dYcm85RlZk?=
 =?utf-8?B?aC9kajFXQ2tBSGxnODNhdWdBYjdZZXBwL29MVU8vclV1QStHWXlOVE5IVnRl?=
 =?utf-8?Q?vwPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bd6b76-d270-465e-8e16-08da8a4a3d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 05:41:08.4511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRjF7Tidz+wWd1QBw44xKUbZBTV3vRZakHEfD8xw5SwslbOfgnXmZS4ytC6gyosa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLiANCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0
IDI0LCAyMDIyIDY6MjggUE0NCj4gVG86IE1hbm5lLCBOYXZhIGtpc2hvcmUgPG5hdmEua2lzaG9y
ZS5tYW5uZUBhbWQuY29tPjsgZ2l0IChBTUQtWGlsaW54KQ0KPiA8Z2l0QGFtZC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gbWlj
aGFsLnNpbWVrQHhpbGlueC5jb207IG1kZkBrZXJuZWwub3JnOyBoYW8ud3VAaW50ZWwuY29tOw0K
PiB5aWx1bi54dUBpbnRlbC5jb207IHRyaXhAcmVkaGF0LmNvbTsgcC56YWJlbEBwZW5ndXRyb25p
eC5kZTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHJvbmFrLmphaW5AeGlsaW54LmNv
bTsgcmFqYW4udmFqYUB4aWxpbnguY29tOw0KPiBhYmh5dWRheS5nb2RoYXNhcmFAeGlsaW54LmNv
bTsgcGl5dXNoLm1laHRhQHhpbGlueC5jb207DQo+IGxha3NobWkuc2FpLmtyaXNobmEucG90dGh1
cmlAeGlsaW54LmNvbTsgaGFyc2hhLmhhcnNoYUB4aWxpbnguY29tOw0KPiBsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc7IG5hdmEubWFubmVAeGlsaW54LmNvbTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMy80XSBiaW5kaW5nczogZmlybXdhcmU6IFVwZGF0ZSBiaW5kaW5n
IGRvYyBmb3IgdGhlDQo+IHp5bnFtcCBhZmkgY29uZmlnIG5vZGUNCj4gDQo+IFVzZSBzdWJqZWN0
IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0gKGdpdCBsb2cgLS1vbmVsaW5lIC0tIC4u
LikuDQo+IA0KPiAiYmluZGluZ3MiIGlzIG5vIGNvcnJlY3QuDQoNCldpbGwgZml4IGluIHYyLg0K
DQo+IA0KPiBPbiAyNC8wOC8yMDIyIDA2OjU1LCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+
ID4gVXBkYXRlcyBiaW5kaW5nIGRvY3VtZW50IGZvciB0aGUgenlucW1wIGFmaSBjb25maWcgbm9k
ZSB0byBoYW5kbGUgdGhlDQo+ID4gUFNfUEwgQnVzLXdpZHRoIGFuZCByZXNldHMuDQo+IA0KPiBV
c2UgaW1wZXJhdGl2ZSBsYW5ndWFnZToNCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjUuMTcuMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Yg0KPiBtaXR0aW5nLXBh
dGNoZXMucnN0I0w5NQ0KDQpXaWxsIGZpeCBpbiB2Mi4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhLmtpc2hvcmUubWFubmVAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgLi4uL2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC1maXJtd2Fy
ZS55YW1sICAgICB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZmlybXdhcmUveGlsaW54L3hsbngsenlucW1wLQ0KPiBmaXJtd2ENCj4gPiByZS55
YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUveGls
aW54L3hsbngsenlucW1wLQ0KPiBmaXJtd2ENCj4gPiByZS55YW1sIGluZGV4IGYxNGY3YjQ1NGYw
Ny4uOTUwNDY2NWNhZDk1IDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC0NCj4gZmlybXdhDQo+
ID4gcmUueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9m
aXJtd2FyZS94aWxpbngveGxueCx6eW5xbXAtZmkNCj4gPiArKysgcm13YXJlLnlhbWwNCj4gPiBA
QCAtNTksNiArNTksMTMgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgY29udHJvbGxlci4NCj4g
PiAgICAgIHR5cGU6IG9iamVjdA0KPiA+DQo+ID4gKyAgenlucW1wLWZwZ2E6DQo+IA0KPiBKdXN0
OiBmcGdhDQo+IA0KIA0KV2lsbCBmaXggaW4gdjIuDQoNClJlZ2FyZHMsDQpOYXZha2lzaG9yZS4N
Cg==
