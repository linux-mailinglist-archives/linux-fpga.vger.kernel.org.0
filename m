Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0902853710A
	for <lists+linux-fpga@lfdr.de>; Sun, 29 May 2022 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiE2NDW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiE2NDV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 09:03:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4F0473A3;
        Sun, 29 May 2022 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653829397; x=1685365397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qTIQgyf9r5wPlnyF5g2mzuzrLrWas3cqm29xihgeGfI=;
  b=jRVHkioWKyesaekD2tYdqHUUrTQMbZed+EWhMJIik3GpGbrWUy8cNi+/
   0gaRzV5DTdAACqUU0hs5/4T0xmQH5GrvDKPiIHssQWWgAzrtXlm2Zw8Bm
   aATbys/xwJiqSJlRwCS+uCmRxc9GoeRvB9DtMN0aD7XHEMMPQ4u5qXcw/
   9z3LI1qywJkQ0Y2IAwkRxo5/WBC5Df/t4KLb2i7/V9S/w7gLEFhTXLRnF
   zPsQB2cDmO7q6QolkycVAflFJWC4lBBozWTIbYH2JAxq+FK1Ch4ORlu2v
   CViRAaqTRhxwukTyGaDkWKt3QDpYsWTMUeYe1lmQb8Jzm8AKkRz8E4UZo
   A==;
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="175570372"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2022 06:03:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 29 May 2022 06:03:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 29 May 2022 06:03:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpkn4TbonwtOGZTl9VDOupw7suFLmxcLHjKvX9J2JAu1D9iZsQaOBBM/MVi8gark3ApFFIlmmLfZ//6NuJgALWiBB2IB3YZFPh4Q5EeV++JKddtfasXrvpTDQSO65SzJKxJIPxGxpbxvSmGAdqbqOhr9mDJ88WNGC7wLhJcRT7fUjOoFeINq6gQNEa4kzAloODLWbFhZHU5q+LoGnPIu8bK1Z85h6S7i4hstkFFV8XwHfTQyTeIwH+MfHxlQSjgCtLa0ZR0XwHPnUNRlSTyWy86jkkkq1oyawN3CI1CVJgsyGT7cnMFz+2zwxU59LFzpXIKB/OxRePJHj0pET14KGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTIQgyf9r5wPlnyF5g2mzuzrLrWas3cqm29xihgeGfI=;
 b=dJgQCGteFuYCm/XCKLef57FfVTYKK9F10zO1zFYqOQ2da3o5kExZHD//Tr3DZgXmOiP1ey4Yi3aV33bapqQ/BUcu/tCmKiYWRz3m9KKBSpM9uF4wuRxGQpuv1Z0QRMOhM8jag/reoetFh+RE+cY75gmPe/Nm1BBuarPAvkpBkbCRlfWApQ7LHZ4t7bPLHDy/93/UGjo9pfIuyrBkQ5yeihn/caeq5fwaynPQrLsGbNHEsmBDNaG+iot9pnOyx3dJNtRaPh7O8cpjgP4NmFqFy/aLojKKeIIu8HOmd18QrTF8kMJuPbc1bz8dv84NCU4Hc+F8t4il4t8dsEPoRdXyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTIQgyf9r5wPlnyF5g2mzuzrLrWas3cqm29xihgeGfI=;
 b=ntPO7OjH3H2GFX4EelWkD6gBBqW7H3+sM+Wb9TQhCeuD9MiKEkhIPbzzC4V70lLAGwJEaA2NLS2LExTbiodNlcdNakoD0cP/l76aLGIECgyxvoAXStsJqxJhqploha3PpuzZtMI2juhbxaYUttrqBKsp94tTDWFXRhzHrDoawCc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Sun, 29 May
 2022 13:03:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.018; Sun, 29 May 2022
 13:03:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yilun.xu@intel.com>, <i.bornyakov@metrotek.ru>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <trix@redhat.com>,
        <Conor.Dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <system@metrotek.ru>
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYcS+MqDCo1uYFDUerOTfzxMPcoq010AUAgAAGgAA=
Date:   Sun, 29 May 2022 13:03:10 +0000
Message-ID: <3d44115c-08c8-07ee-e707-617cfbe0352f@microchip.com>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <20220529123954.GB185904@yilunxu-OptiPlex-7050>
In-Reply-To: <20220529123954.GB185904@yilunxu-OptiPlex-7050>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8439e1b8-6c3d-40eb-eb94-08da4173955e
x-ms-traffictypediagnostic: MW4PR11MB5891:EE_
x-microsoft-antispam-prvs: <MW4PR11MB5891958B0F82C8BA21F863C798DA9@MW4PR11MB5891.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0nPSO7lCE03vfWZpV7VNj2rXBh0lQVM4RxRE2r3dvYfOczr+kgW50bKme4MhMpt0IjHqXozC0nN/k63OafhNCV6p4U0TM3SvZR4h+/m1EgE6+zk+O9xvlGehdYfFEYkX9q1fpWpDTzJSwT6gHkeaDmPyE8/IBrqCWmouSwpwyrs5TnXSBH678YDEksbGBp5+EkMYw0fcef8DoXK/3wQfcMro0lki2Taljb1SyRFoMK/jY+IE3vykC/nhbPNQY74sJNZcpQxaV4UjRq6bnL0MMnRnT881f7OHbRBelh8KpPtHKrQGoMpLPuc/de45mXyElc0fTYWpOLXHRfnOvZh4zFllqEPAY6dn/cWh6qYaeJc2IUq8mzQl1AHZpVEhy9ufoqg9xSUulDrCVYOPDLzXPcM2wc5k7Ckr+NMi3oSDnM+Dp9KlstlTeC/zLtunm+/l6PiSqk3XKWE5/HVbWiXVLZCwLvyXepfuCDOpdwzVoH12HyEqAc9mOoke3H4dFF7jB6Uv/VEVJwxsLN6e5v3L+wtLhJ0VwDzC1g3eurzN9k65ThDq56/zSb/ZCjNA7144r0zNIiE0d2xZEfZxn4RrjbZdAz0ywrcltOt4kQ3vACX9cErANj8brQssHnJ1prcA/ugOa330CrLCQUW0qpsjM+akJaGdzBXHgL4F+aymkjxE64YKSrdAEOf9MO4MqJxYkWyv5vcjRUdcB/AERQnr41o3KYpckeTC/+WOSA17WrAhrWtQWedrKOzZFb1nM5UXwgVReHc6U7e+8ZqibWVbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(8936002)(7416002)(5660300002)(8676002)(64756008)(4326008)(54906003)(66946007)(66556008)(110136005)(71200400001)(76116006)(31696002)(91956017)(38100700002)(36756003)(31686004)(316002)(86362001)(508600001)(26005)(6486002)(53546011)(122000001)(2906002)(6506007)(6512007)(186003)(2616005)(38070700005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTVMQndQV2hIZzZrYzByajUralE3RXcyRFltYmRtWmkrMlB2K21URC9ZaHdP?=
 =?utf-8?B?OEZDOTRpa2oyejk5L2JTd3ExcnJEeHBYY2ZHcHZkdzltOW42M0FCZjBacC9a?=
 =?utf-8?B?Um1uWExrVSt3cThWcFU2WEJGbm93eW9uVGhrNURHdjF4aGlvVG5LMUl0VytI?=
 =?utf-8?B?NHBJR0VzN2wzMmQ3YnRINndzaUx5c29XM2RQNzNEdEdnaEEwYkJBT1FkTnlw?=
 =?utf-8?B?ZEVJc0Jnc0RtSlBaWnVLS0dLdGw1azdwbkd3ZFUvSTFCQTJ4amZKVi9mRDBB?=
 =?utf-8?B?VVJJeVJONU12WkFnRUlzWlhCcVFqKzdnS0tma2JHK3NWUDV1Qi8rZ0UvOHRF?=
 =?utf-8?B?VXhUQW9CbjRwZWd0VG5FWkVDcm1xVjBrYVU4b2Jyd1ErMHBQTy92NXhYeUpR?=
 =?utf-8?B?bGJkUVJCaVA5ZTRlV09nWkRubElxVERGbHQxZlZJc3YrVWoySnVOZTcxb3hW?=
 =?utf-8?B?Y3Z2OEJwUGNjdCs5Z2g5Y3JWN3hsVjBqSFJuWTU4UVM5Uk52MHErR2VuUmsy?=
 =?utf-8?B?dC8vVjdmQ0RMbGlJOWsxNmwwMnZPTXZ5S2hlbG5leG1YYWM1bGZIZVUrVEZ0?=
 =?utf-8?B?dXVLeU1lS08zQVVTc2FqMVJjckkxb3NadmFuK1Z3WXFSS3VMYXJhbU8zZTdZ?=
 =?utf-8?B?b0xrUmVwenRJTEdmeEV3QnU2RzhIRlBES3ZsYUROU0swa3d4MGZhR29CSlkr?=
 =?utf-8?B?WHkxRlRhNVpKNWwyVG92bDZ5RnNRMkVGRk1UVnZlNEtxRy9vNm1vSzdMbHFT?=
 =?utf-8?B?V3RvNXRLbm1uVDJqbGozRHFvZ3JUdktSNWU3YkR5b1I0NE5nWGxxOVEvT1c5?=
 =?utf-8?B?MGtTb3c0cG1VZFhCcS9jMHRoL1FJYUwzMjFBeFJ4NERqd2hiOVVaZGZXS0hZ?=
 =?utf-8?B?ZXIvMWs3SXhRc1ZtcnJ6dWFyYTBCSXR3dVBnenBaTUZ5a3ROSUdYb3ZSZzlN?=
 =?utf-8?B?dlNwa0FyT0M0aWxDZlBuT1NoQndIeFdMc0tQQVNHbGhPWERsNzlCU09mWExW?=
 =?utf-8?B?SzBUb0wrRFRTY2ZZQ0QyemhLMlZxSUdCRWxZMTNicUpyKzFyZXIyL3Z4YVpi?=
 =?utf-8?B?bm9vQTMyREl0R2c4dmMzWW1oeVo1c1dUVjRvaUdrTmFtdkYzdmpoK2tYSDVR?=
 =?utf-8?B?cFRKc0tQZC84QndKeUcyVHozT0ZoSTdML3BET1NaWUlnUlJrOXFleWtjRFFa?=
 =?utf-8?B?WWV2eVNHYy9ob1JyRUN5ZTJPUlI2amhLNmxGK0QwUHhhSjlyQnFKdVNVSkJx?=
 =?utf-8?B?MkNOYkxSVytwNklOaEVnVUJWcHJJbVlseUtYTWk3Z2QrMjVhOUN2dGFlMVVH?=
 =?utf-8?B?eVphdU12STNUdmoxZzBTbmxvSTZLeGtJd2VZMjZaeDl6NWsrZlk4OTRVcXZr?=
 =?utf-8?B?S1dSNE03WGNEcWY2SUk5Mk9zVk1HS1JiWXBmdWl6UkpsSGUrVUYvWk96eGlI?=
 =?utf-8?B?b1NuRUFid05uMXQvL2paQ29PYnZpZVkycE9FWUZhNm5QYjdsNGRmVmlqRTUw?=
 =?utf-8?B?bHhhR0xKb2JueGFsaEp3MTZRU0g1cjY2cDBOeXZBbFZqaTdtNTZjM3dYYjYz?=
 =?utf-8?B?Z1VaK2Rlcld4bEhhRTZXc0N2ZjR2V1BJL0NJZGVQaThIV1krb2owOVdhcHhQ?=
 =?utf-8?B?aWxwZFk3Ti83elZ2R1pERXBPL1lYNlh4N3czZzhDamdMdzc0RjErRnpIbU5K?=
 =?utf-8?B?eXl2SzZYWGk4NkM0cUFtcmFTaHo4Ym4zOEt0S253dmNxQUYvcm1FMSt5ekEv?=
 =?utf-8?B?WVhvb2dHRDhrUm5PWGNmQmtPc0w4S1gyYUM2TjNZNnBzM2g3d242OU9BVmpC?=
 =?utf-8?B?QXA4ZFFBbExCZzBxWm1sVXRtOGZkZldvRGo3ZkZTMEszYkVqVmpndlVxWUNp?=
 =?utf-8?B?TSt0RHVYbS9wZ01pMnJBTjhUenJvYU9mbGZRZWU5UlJqbDR3Z2wvUW5tNkps?=
 =?utf-8?B?cUEya2ZXbkVjcmJ6OUdpSm5uenJIN1FnTkpiMEN1WlI3M0llcmtqdUZNcnlF?=
 =?utf-8?B?WWdHNGJhTkkxMzgxdGNHLzAxcDdFeXpSTDhUMXQ2SWx2c2JZNUdyeThQK21i?=
 =?utf-8?B?MkI0bTZUUFhpendnbzNDNEprUnowZFRaL2xYNWwrMDBjYUgxZThPWnJPRktE?=
 =?utf-8?B?SnRmTUVtSlhqLzBsNU5VSG01STh1c3dvYUcrNE42V2hyV2ZzaGRpUGhRb0NO?=
 =?utf-8?B?UkVueEpjMkdHTWwvamREU0ZTaUwzTHlPeE9lZGkxdmE0VDdBajBuOFdsRS9I?=
 =?utf-8?B?R2l4MEo4d1pJay9Ec25lOGJGVDJtRzN1dzFyeUhPOXd5YlVKQloxRlNpRUpK?=
 =?utf-8?B?WjROcXpTN09CK2JSaHg4OU5weDl2cE5wOENoRUp6NktBbU9qbTh4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED33EFB7CFB6554AAA6297DCE1187D5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8439e1b8-6c3d-40eb-eb94-08da4173955e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2022 13:03:10.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9Srg58XrW1d62py7VynYSsWoYkxh+1ux4V35mqMtk4IX5M8fHpEc7odwVizxTHCh1M41l17Juj5QOE43Zi7WPrkYe32SC9+6zqIc14x0Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMjkvMDUvMjAyMiAxMzozOSwgWHUgWWlsdW4gd3JvdGU6DQo+IE9uIFRodSwgTWF5IDI2LCAy
MDIyIGF0IDA5OjEzOjQzUE0gKzAzMDAsIEl2YW4gQm9ybnlha292IHdyb3RlOg0KPj4gQWRkIHN1
cHBvcnQgdG8gdGhlIEZQR0EgbWFuYWdlciBmb3IgcHJvZ3JhbW1pbmcgTWljcm9jaGlwIFBvbGFy
ZmlyZQ0KPj4gRlBHQXMgb3ZlciBzbGF2ZSBTUEkgaW50ZXJmYWNlIHdpdGggLmRhdCBmb3JtYXR0
ZWQgYml0c3JlYW0gaW1hZ2UuDQo+IA0KPiBGcm9tIHByZXZpb3VzIG1haWwgdGhyZWFkLCB0aGVy
ZSBhcmUgc3RpbGwgc29tZSBoYXJkd2FyZSBvcGVyYXRpb25zIHlldA0KPiB0byBiZSBjbGFyaWZp
ZWQsIHNvIEkgbWF5IG5lZWQgYSBSZXZpZXdlZC1ieSBmcm9tIENvbm9yLkRvb2xleUBtaWNyb2No
aXAuY29tLg0KDQpZZWFoLCB3YXMgcmVhbGx5IGJ1c3kgbGFzdCB3ZWVrLiBQbGFubmluZyBvbiBn
aXZpbmcgdGhpcyB2ZXJzaW9uIGEgZ28NCnRvbW9ycm93LiBJICp0aGluayogSSBleHBsYWluZWQg
dGhlIHJlYXNvbiB0aGUgc3RhdHVzIGNoZWNrIG5lZWRlZCB0byBiZSBhDQpzeW5jX3RyYW5zZmVy
KCkgYnV0IGl0IGhhc24ndCBiZWVuIHJlZmxlY3RlZCBpbiBhIGNvbW1lbnQgeWV0Lg0KDQpJIGRp
ZG4ndCBrbm93IHRoZSBhbnN3ZXJzIHRvIHRoZSB0d28gb3RoZXIgcXVlc3Rpb25zICYgcGFzc2Vk
IHRoZW0gb24gdG8gdGhlDQpkZXNpZ25lcnMgb2YgdGhlIGhhcmR3YXJlIGJsb2NrcyAtIGJ1dCBi
b3RoIGFyZSB0cmF2ZWxpbmcgc28gbm90IGdvdCBhDQpyZXNwb25zZSB5ZXQuIFRoZXJlJ3Mgb25l
IGJpdCBvZiBjbGFyaWZpY2F0aW9uIEknZCBsaWtlIGZyb20geW91cjoNCg0KPj4+ICtzdGF0aWMg
aW50IG1wZl9vcHNfd3JpdGUoc3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyLCBjb25zdCBjaGFyICpi
dWYsIHNpemVfdCBjb3VudCkNCj4+PiArew0KPj4+ICsJdTggdG1wX2J1ZltNUEZfU1BJX0ZSQU1F
X1NJWkUgKyAxXSA9IHsgTVBGX1NQSV9GUkFNRSwgfTsNCj4+PiArCXN0cnVjdCBtcGZfcHJpdiAq
cHJpdiA9IG1nci0+cHJpdjsNCj4+PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZtZ3ItPmRldjsN
Cj4+PiArCXN0cnVjdCBzcGlfZGV2aWNlICpzcGk7DQo+Pj4gKwlpbnQgcmV0LCBpOw0KPj4+ICsN
Cj4+PiArCWlmIChjb3VudCAlIE1QRl9TUElfRlJBTUVfU0laRSkgew0KPj4+ICsJCWRldl9lcnIo
ZGV2LCAiQml0c3RyZWFtIHNpemUgaXMgbm90IGEgbXVsdGlwbGUgb2YgJWRcbiIsDQo+Pj4gKwkJ
CU1QRl9TUElfRlJBTUVfU0laRSk7DQo+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKwl9DQo+
Pj4gKw0KPj4+ICsJc3BpID0gcHJpdi0+c3BpOw0KPj4+ICsNCj4+PiArCWZvciAoaSA9IDA7IGkg
PCBjb3VudCAvIE1QRl9TUElfRlJBTUVfU0laRTsgaSsrKSB7DQo+Pj4gKwkJbWVtY3B5KHRtcF9i
dWYgKyAxLCBidWYgKyBpICogTVBGX1NQSV9GUkFNRV9TSVpFLA0KPj4+ICsJCSAgICAgICBNUEZf
U1BJX0ZSQU1FX1NJWkUpOw0KPj4+ICsNCj4+PiArCQlyZXQgPSBtcGZfc3BpX3dyaXRlKHNwaSwg
dG1wX2J1Ziwgc2l6ZW9mKHRtcF9idWYpKTsNCj4+DQo+PiBBcyBJIG1lbnRpb25lZCBiZWZvcmUs
IGlzIGl0IHBvc3NpYmxlIHdlIHVzZSBzcGlfc3luY190cmFuc2ZlciB0byBhdm9pZA0KPj4gbWVt
Y3B5IHRoZSB3aG9sZSBiaXRzdHJlYW0/DQo+DQo+IFVuZm9ydHVuYXRlbHksIEkgZGlkbid0IHN1
Y2NlZWQgd2l0aCBzcGlfc3VuY190cmFuc2ZlciBoZXJlLiBNYXkgYmUNCj4gQ29ub3Igb3Igb3Ro
ZXIgZm9sa3Mgd2l0aCBtb3JlIGluc2lnaHQgb24gTWljcm9jaGlwJ3MgSFcgd291bGQgYmUgYWJs
ZQ0KPiB0byBlbGltaW5hdGUgdGhpcyBtZW1jcHkuLi4NCg0KSSB1bmRlcnN0b29kIHRoaXMgYXMg
YmVpbmcgYSBxdWVzdGlvbiBhYm91dCB3aHkgaXQgd2FzIHJlcXVpcmVkIHRvIGNoZWNrDQp0aGUg
c3RhdHVzIG9mIHRoZSBoYXJkd2FyZSBiZXR3ZWVuIGZyYW1lcyBvZiB0aGUgYml0c3RyZWFtIHJh
dGhlciB0aGFuDQp1c2luZyBzcGlfc3luY190cmFuc2ZlcigpIHRvIGNvcHkgZWFjaCBmcmFtZSBi
YWNrIHRvIGJhY2suDQoNCklzIHRoYXQgY29ycmVjdD8NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCg0K
PiANCj4gWy4uLl0NCj4gDQo+IA0KPj4gK3N0YXRpYyBpbnQgbXBmX29wc19wYXJzZV9oZWFkZXIo
c3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyLA0KPj4gKwkJCQlzdHJ1Y3QgZnBnYV9pbWFnZV9pbmZv
ICppbmZvLA0KPj4gKwkJCQljb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkNCj4+ICt7DQo+
PiArCXNpemVfdCBjb21wb25lbnRfc2l6ZV9ieXRlX251bSwgY29tcG9uZW50X3NpemVfYnl0ZV9v
ZmYsDQo+PiArCSAgICAgICBjb21wb25lbnRzX3NpemVfc3RhcnQsIGJpdHN0cmVhbV9zdGFydCwg
aSwNCj4+ICsJICAgICAgIGJsb2NrX2lkX29mZnNldCwgYmxvY2tfc3RhcnRfb2Zmc2V0Ow0KPj4g
Kwl1OCBoZWFkZXJfc2l6ZSwgYmxvY2tzX251bSwgYmxvY2tfaWQ7DQo+IA0KPiBJIHRoaW5rIGNv
bXBvbmVudF9zaXplX2J5dGVfbnVtLCBjb21wb25lbnRfc2l6ZV9ieXRlX29mZiwgaSBzaG91bGQg
YmUgc2l6ZV90DQo+IGFyZSBhbGwgc2ltcGxlIG51bWJlcnMgaXJyZWxhdGVkIHRvIGRhdGEgc2l6
ZSwgc28gbWF5YmUgdTMyIGlzIGp1c3QgZ29vZC4NCj4gDQo+IFRoYW5rcywNCj4gWWlsdW4NCj4g
DQo+PiArCXUzMiBibG9ja19zdGFydCwgY29tcG9uZW50X3NpemU7DQo+PiArCXUxNiBjb21wb25l
bnRzX251bTsNCj4+ICsNCj4+ICsJaWYgKCFidWYpIHsNCj4+ICsJCWRldl9lcnIoJm1nci0+ZGV2
LCAiSW1hZ2UgYnVmZmVyIGlzIG5vdCBwcm92aWRlZFxuIik7DQo+PiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwloZWFkZXJfc2l6ZSA9ICooYnVmICsgTVBGX0hFQURFUl9T
SVpFX09GRlNFVCk7DQo+PiArCWlmIChoZWFkZXJfc2l6ZSA+IGNvdW50KSB7DQo+PiArCQlpbmZv
LT5oZWFkZXJfc2l6ZSA9IGhlYWRlcl9zaXplOw0KPj4gKwkJcmV0dXJuIC1FQUdBSU47DQo+PiAr
CX0NCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogR28gdGhyb3VnaCBsb29rLXVwIHRhYmxlIHRvIGZp
bmQgb3V0IHdoZXJlIGFjdHVhbCBiaXRzdHJlYW0gc3RhcnRzDQo+PiArCSAqIGFuZCB3aGVyZSBz
aXplcyBvZiBjb21wb25lbnRzIG9mIHRoZSBiaXRzdHJlYW0gbGllcy4NCj4+ICsJICovDQo+PiAr
CWJsb2Nrc19udW0gPSAqKGJ1ZiArIGhlYWRlcl9zaXplIC0gMSk7DQo+PiArCWJsb2NrX2lkX29m
ZnNldCA9IGhlYWRlcl9zaXplICsgTVBGX0xPT0tVUF9UQUJMRV9CTE9DS19JRF9PRkZTRVQ7DQo+
PiArCWJsb2NrX3N0YXJ0X29mZnNldCA9IGhlYWRlcl9zaXplICsgTVBGX0xPT0tVUF9UQUJMRV9C
TE9DS19TVEFSVF9PRkZTRVQ7DQo+PiArDQo+PiArCWhlYWRlcl9zaXplICs9IGJsb2Nrc19udW0g
KiBNUEZfTE9PS1VQX1RBQkxFX1JFQ09SRF9TSVpFOw0KPj4gKwlpZiAoaGVhZGVyX3NpemUgPiBj
b3VudCkgew0KPj4gKwkJaW5mby0+aGVhZGVyX3NpemUgPSBoZWFkZXJfc2l6ZTsNCj4+ICsJCXJl
dHVybiAtRUFHQUlOOw0KPj4gKwl9DQo+PiArDQo+PiArCWNvbXBvbmVudHNfc2l6ZV9zdGFydCA9
IDA7DQo+PiArCWJpdHN0cmVhbV9zdGFydCA9IDA7DQo+PiArDQo+PiArCXdoaWxlIChibG9ja3Nf
bnVtLS0pIHsNCj4+ICsJCWJsb2NrX2lkID0gKihidWYgKyBibG9ja19pZF9vZmZzZXQpOw0KPj4g
KwkJYmxvY2tfc3RhcnQgPSBnZXRfdW5hbGlnbmVkX2xlMzIoYnVmICsgYmxvY2tfc3RhcnRfb2Zm
c2V0KTsNCj4+ICsNCj4+ICsJCXN3aXRjaCAoYmxvY2tfaWQpIHsNCj4+ICsJCWNhc2UgTVBGX0JJ
VFNUUkVBTV9JRDoNCj4+ICsJCQlpbmZvLT5oZWFkZXJfc2l6ZSA9IGJpdHN0cmVhbV9zdGFydCA9
IGJsb2NrX3N0YXJ0Ow0KPj4gKwkJCWlmIChibG9ja19zdGFydCA+IGNvdW50KQ0KPj4gKwkJCQly
ZXR1cm4gLUVBR0FJTjsNCj4+ICsNCj4+ICsJCQlicmVhazsNCj4+ICsJCWNhc2UgTVBGX0NPTVBP
TkVOVFNfU0laRV9JRDoNCj4+ICsJCQljb21wb25lbnRzX3NpemVfc3RhcnQgPSBibG9ja19zdGFy
dDsNCj4+ICsJCQlicmVhazsNCj4+ICsJCWRlZmF1bHQ6DQo+PiArCQkJYnJlYWs7DQo+PiArCQl9
DQo+PiArDQo+PiArCQlpZiAoYml0c3RyZWFtX3N0YXJ0ICYmIGNvbXBvbmVudHNfc2l6ZV9zdGFy
dCkNCj4+ICsJCQlicmVhazsNCj4+ICsNCj4+ICsJCWJsb2NrX2lkX29mZnNldCArPSBNUEZfTE9P
S1VQX1RBQkxFX1JFQ09SRF9TSVpFOw0KPj4gKwkJYmxvY2tfc3RhcnRfb2Zmc2V0ICs9IE1QRl9M
T09LVVBfVEFCTEVfUkVDT1JEX1NJWkU7DQo+PiArCX0NCj4+ICsNCj4+ICsJaWYgKCFiaXRzdHJl
YW1fc3RhcnQgfHwgIWNvbXBvbmVudHNfc2l6ZV9zdGFydCkgew0KPj4gKwkJZGV2X2VycigmbWdy
LT5kZXYsICJGYWlsZWQgdG8gcGFyc2UgaGVhZGVyIGxvb2stdXAgdGFibGVcbiIpOw0KPj4gKwkJ
cmV0dXJuIC1FRkFVTFQ7DQo+PiArCX0NCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogUGFyc2UgYml0
c3RyZWFtIHNpemUuDQo+PiArCSAqIFNpemVzIG9mIGNvbXBvbmVudHMgb2YgdGhlIGJpdHN0cmVh
bSBhcmUgMjItYml0cyBsb25nIHBsYWNlZCBuZXh0DQo+PiArCSAqIHRvIGVhY2ggb3RoZXIuIElt
YWdlIGhlYWRlciBzaG91bGQgYmUgZXh0ZW5kZWQgYnkgbm93IHVwIHRvIHdoZXJlDQo+PiArCSAq
IGFjdHVhbCBiaXRzdHJlYW0gc3RhcnRzLCBzbyBubyBuZWVkIGZvciBvdmVyZmxvdyBjaGVjayBh
bnltb3JlLg0KPj4gKwkgKi8NCj4+ICsJY29tcG9uZW50c19udW0gPSBnZXRfdW5hbGlnbmVkX2xl
MTYoYnVmICsgTVBGX0RBVEFfU0laRV9PRkZTRVQpOw0KPj4gKw0KPj4gKwlmb3IgKGkgPSAwOyBp
IDwgY29tcG9uZW50c19udW07IGkrKykgew0KPj4gKwkJY29tcG9uZW50X3NpemVfYnl0ZV9udW0g
PQ0KPj4gKwkJCShpICogTVBGX0JJVFNfUEVSX0NPTVBPTkVOVF9TSVpFKSAvIEJJVFNfUEVSX0JZ
VEU7DQo+PiArCQljb21wb25lbnRfc2l6ZV9ieXRlX29mZiA9DQo+PiArCQkJKGkgKiBNUEZfQklU
U19QRVJfQ09NUE9ORU5UX1NJWkUpICUgQklUU19QRVJfQllURTsNCj4+ICsNCj4+ICsJCWNvbXBv
bmVudF9zaXplID0gZ2V0X3VuYWxpZ25lZF9sZTMyKGJ1ZiArDQo+PiArCQkJCQkJICAgIGNvbXBv
bmVudHNfc2l6ZV9zdGFydCArDQo+PiArCQkJCQkJICAgIGNvbXBvbmVudF9zaXplX2J5dGVfbnVt
KTsNCj4+ICsJCWNvbXBvbmVudF9zaXplID4+PSBjb21wb25lbnRfc2l6ZV9ieXRlX29mZjsNCj4+
ICsJCWNvbXBvbmVudF9zaXplICY9IEdFTk1BU0soTVBGX0JJVFNfUEVSX0NPTVBPTkVOVF9TSVpF
IC0gMSwgMCk7DQo+PiArDQo+PiArCQlpbmZvLT5kYXRhX3NpemUgKz0gY29tcG9uZW50X3NpemUg
KiBNUEZfU1BJX0ZSQU1FX1NJWkU7DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiAr
fQ0K
