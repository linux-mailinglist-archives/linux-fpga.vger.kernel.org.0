Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4658463D
	for <lists+linux-fpga@lfdr.de>; Thu, 28 Jul 2022 21:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiG1TTE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Jul 2022 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiG1TTC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Jul 2022 15:19:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E62F019;
        Thu, 28 Jul 2022 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659035938; x=1690571938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IO7cYCJoZPeKKB4dNRbTdej4gmn9lpQPY/zm3DaSPUg=;
  b=C8X2MXIKNxDj6kbDNrPO3BtNYA/dRoPUFrtF/5XP6KE+JyhCjrLSDHLe
   OeLyEt89MphHPhaAHJc0xFTGkS7ROdyGUw4LKkqDKi/U6BokE4fQLMxSP
   LDBugKR7x/Pewejf88kQ2Vx0+Z1te9SkQVP72hbUbOIeI3hYmEKebrkWP
   s/yW7ECYf3TNCp8HSOMQPelbFI+jYghhaZWD60+K8NP3q12+lPcaF5Pqv
   3G8WQFrnbfZxInjom17s1Jb7z1dTpF4z7awXkldkxcJie7Fxqq1uxb1mc
   HIWLYj9Z6ws1Y1gN7qa8sJglixYp1Cr97OYh1PHH7T0Epm+4zjTiw47Z/
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="174048830"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2022 12:18:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 12:18:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 28 Jul 2022 12:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiOmai77aMV3MV/ebGIEouT4/sDyPODHhjaEHl2bbGqP7bcMNWki4YI7d9W9d7nOicTaBgNmfesqO79a9cJcJKOmmJCNPyaFX6ES3pqFPIs7RabXVC6lEVWRIRHViCcgnXbnQ1ureMKe6JWjV0MPNOWPTb8HJad6BQapzMqWvOOHDdTp4wYPnAASfZiIbWDuN+Ot8aDfR8TAgg+yAcIm38n3+nu8BxOQ1JIpGXzx5Lh0pb43yQXtGm/jDOlVgm8xb+g4bN17JWHLv6jeYLMHxBgdLE8RNx7jloCVO/q3bWhGFO2yCYrCQESotlaKbVmGeSDBosO77azeZWdd8dy8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO7cYCJoZPeKKB4dNRbTdej4gmn9lpQPY/zm3DaSPUg=;
 b=VmaBNew+J6CbAxQ5S3nMXr+VoZjzJJbRugU19kLk2XjmPP1sfRH061vgO9DBOK3YmB8DFm0OF4cmMPMcJsjtSXCsQpeNQcyrglkPKooEW3FYCfUeYEIvM+nayVSC5Im52K6erMhCZm0SfstYojHuA5rDDd08eEibdV7IVfO5PF3a7QgRCDyhNu1WCs2UB3oCVUoRYcPka5yZxVaVDPnR5TXIQYy4xfk82nYlNlqRRZXQ8q2mzaGFDVeAGX90I9PfZ2P6fNxrsaStt4W/yr4vnJ6sWVclyn9xsMO3o8hzEf1l7G32mU8WC2Mx7lUMB6oZ7bjOgD8xTUpyEVG6CdclVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO7cYCJoZPeKKB4dNRbTdej4gmn9lpQPY/zm3DaSPUg=;
 b=pjLoEdYbW4oMpi89teFmOsBbUFhBrZbI3sDOfyf863Lb485hHacL7T9xzJgy4/YA4H8H99yCKmyjst6asiSWNUcExTj2EJp4AoI+HOrDvRhd00GGkoI+VTDPIeDB1rB0oHfNWK2sh3iDeJuON4zuanJY14qkWGBtYkJRdlK/Kgg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR1101MB2278.namprd11.prod.outlook.com (2603:10b6:910:18::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 19:18:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 19:18:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>, <Conor.Dooley@microchip.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: microchip-spi: add missing module author entry
Thread-Topic: [PATCH] fpga: microchip-spi: add missing module author entry
Thread-Index: AQHYola1HluXf+EOdk6iAQMM/wEnGa2UIB0AgAAI9YA=
Date:   Thu, 28 Jul 2022 19:18:54 +0000
Message-ID: <b2ae744c-990f-a432-7cd5-b7e1e440ad4e@microchip.com>
References: <20220728075012.3136914-1-conor.dooley@microchip.com>
 <20220728184650.6wa5zwbrciatfsba@x260>
In-Reply-To: <20220728184650.6wa5zwbrciatfsba@x260>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebef8921-857c-42b4-8854-08da70ce02f2
x-ms-traffictypediagnostic: CY4PR1101MB2278:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbFhGdWez8A9aX/+Va1ss1lrqJZqAKhvQ4art1vPxwm6GZwOGxCO7QSiWDYSeibxU86JIBv3VV4w6isazvy49lWPo8ApNHCdB9x7lR4wtS68wcTgNoRqlOG2eOguHBxxsOGHXehx2Obz0dr1LfoTN2t0Lw0H81MBcm7jM5MiAxZnWAd0m6CQUzyX6hcJsiGsH7/lCDyc6laTu32e1R24kBwoL2t1L1k2k/W3RiTmsNbSe1aUOirekUBjqgop8rsVhspSu/fJ53srv9K2LUBoW4/PVzktyZetgqnhyL5IU1GTNZekjn04js2SsJcYGQzS0ebfbFmQoZkBYbA6sP+2XHzPT0G4+TfPpmfuUWyuAhkLTicBTLWW4e0LIqKWRG1oyZrXSFjRaYaFTkc/cSiK5Qumz/eMqLmQDrCxbL0TWStNRzs+FMFUAjtQp5CD/jCY/HQxrt0fVZ1d1/4Q4xMzntTvihRo4dLknJ863TsAqepgQiKtldg0VYdlHd7kMm+qp9iD3abNAInU17qY8cvxtuZrR3zxRa+er9dK66REGgwyasrsQiAAFkPtUYyIlO4g7Klvre7crgf0zpXmR+Q/G/zRq+F2W9u6wmpcsdT7ny/dv5wsuvK/+rFIcRU3mvROLRFj1JUBv0h7iLCyfNPZlbbl1ynrhBtxgr3yzlRS60qRM4X/htFjPESkcBexLrjWo4xL31ujs15cHSqW3Ln4brHruYBNA4V/Pe4O2IUDo/+U5sh4e43mTgwqunXZEfK8X7LjvCRNpMrVwW7CDNVK6qXqqRZyyXNpDwvpSgxkvZzI/xQiM4KrII5cI1el6JMbyAhbkEfeuuhYkf3892g+6uPk4CTAYGxjGjSz1RsJ69BpEHQ+Wy8jVqnU42lSPnZA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(31696002)(6486002)(478600001)(71200400001)(38070700005)(36756003)(31686004)(2616005)(6506007)(41300700001)(54906003)(186003)(6512007)(53546011)(110136005)(38100700002)(4326008)(76116006)(316002)(26005)(8676002)(5660300002)(86362001)(64756008)(91956017)(8936002)(66446008)(2906002)(66946007)(66556008)(122000001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3Rmd2krSUxCQ0V3SkZRbFgrL3BnQW5pWEF5c3lCRXJHOFdQQmQ3aG5LTnpn?=
 =?utf-8?B?UkZ4U3VVaEpDMS9yTXdZc3h1bWVpcVRCdTlkQUpFWGpXQmxNQnlPcFc5QU45?=
 =?utf-8?B?WjB5aWJadGVISU1IT05ZaVN2ZGlaQmNBVC8rellpSzJoS094Rmw2dlRxczdu?=
 =?utf-8?B?M0RVcEtkSWtjdnRWZmJHcGl4bGp4YUlvM2tpYVY3TXZPS2NiUzZNRUMvbnV3?=
 =?utf-8?B?TzZTYk9idCs5YnhmQkIwTURPVWM5NDcyVnd4TkNWaXhCeGU2NkJWY3grYzAw?=
 =?utf-8?B?SVZsb0VYUFBGRGxHWTB5SjFSS3VzaUNXMXczS2taakw0QS9nL2FMZnU3R29u?=
 =?utf-8?B?dmhtNWZZYjRiV0tUeitCMHVkQWl4WFNubDBHVUpOS09OVzJmMDBJbGs0T1hJ?=
 =?utf-8?B?bjJwZVBVdWk0aTNDVTBsbm1mSFAyUG1ydTl6MWNwWk1zTFlhMXBVMHpIY2tw?=
 =?utf-8?B?VjVpeHNhZkNjWWNLeUZlRjZIQnlUUzMzZnIwNmpKR3RuUDVZNGsyUUhSZVM3?=
 =?utf-8?B?bzdvall6T3p5eWsxUmlGelJzbnJKa1J6UlF3U29lWVNIb29GMkx2K21EOEJl?=
 =?utf-8?B?ZmtDaDlsZHdMa2R3QnVvNXN6L0ZxaGFPOG5RNml5NEREMlJmZy85NFpiaURN?=
 =?utf-8?B?bXppVklNbDBDZ1EzMzNGVlpJOHh3bDFlQ1R0ZVlsU3lWTk0vcFM5eHovTmdC?=
 =?utf-8?B?YXBoUmZNWnJNUmYzNHdIb0hOU2NnVHJvSW93cTJYMDlRc1kzWmpzdkRDTllJ?=
 =?utf-8?B?bXBFb1R6aWFCdDM1djhqSE9ENEJhS3M1djFrRHNZMkdoaEJsUlFDS1IxTVFV?=
 =?utf-8?B?ejluT2p0TmpQYmtJK2ZHOE5SSTJFZ3dZVnFIZ1JpZDVhZFFPRTI0UHZpZHZI?=
 =?utf-8?B?cGpBbFRkVHVpZFBTK3VDNlBlNU42THNVUmxhN1dMUEpxTlErWDZoZEFNUlg4?=
 =?utf-8?B?WDBjR1dCeXlxNlJsLzl1S1EydmtXdTVqVlZzZHc1eEtyVEhPZzBlbDM0R3Y3?=
 =?utf-8?B?NVdQMVNPRmxVYmpnMEFYNkxvUHlGc3BGbXJ3TFQrcTRPcXJEcVFoK2xPVi85?=
 =?utf-8?B?VHhVbmJUS210Yy9kTGZJeTBFelU3bEsrd2EyYSt5RnZLNHBIQk45TGxvQnZp?=
 =?utf-8?B?dUk4Vi9udEp4Tnp3elN6UzVqUzhFMW9jWHpvbUE5bE02Nkw3MDhVSG8yMzVy?=
 =?utf-8?B?KzhLb1NsdHFXWkorTkovOFVIaERpeTZyc0lqenJlUElYeTlybDZwTUpYTWNw?=
 =?utf-8?B?SXlTTnBqYURpM25TaytKamFjNjdJamdQbFdpUStjM0xwNVgvV1Irdzc1YnVH?=
 =?utf-8?B?M3NDOTZnK2xyL2lkc0FXR29rdGFjWXJ1Y3lESE10UUlIM2RxWkFwa1Z3Wmor?=
 =?utf-8?B?UGU4UjZKci9GYkFEVkc5eGpQRFVCWngyM1NoYlgveUkvRGtLVTVJcUU3RG5a?=
 =?utf-8?B?ZFRlYUVkTWpZb1ZtNXBhdVB4ME9yWmtvdTJZTTVad3NKaUhjekgzZStsQnJH?=
 =?utf-8?B?VTJIWUlUZkNleTl1TVhCVytlNzZiQitLSGF5cm4xQk8xQVg0MEJ4VEFuMzJ1?=
 =?utf-8?B?YW9IaDJJeDJkQ2pyQ3hmQkZUTEU3K08wM205THVxYzZ3elBXdFJ4SlozTHIr?=
 =?utf-8?B?TTlNV2NDVTJ5RDJpaGZrZGFKcEd0NElmVFRXZkVFMGN4VXV6VTBteXFEek5N?=
 =?utf-8?B?SzhadnhNc054bUxSSURTZTJXdDJrNEcyOUFNbmJuc2lHSzNZV21Nd3FFZnBJ?=
 =?utf-8?B?a3A1TmlUc0FJMU81eDBRTFNBcm5LZlIrZFQ4OHRJeUlELzdKb1JrZ0g0dzFW?=
 =?utf-8?B?S2ptaERhZlpOR1U0Kzd3dkI3TFovdHZtLzUvWTY5cTcwT1JwVGI1WWlwdFNE?=
 =?utf-8?B?MjMvaStuVXBSSk1VZUh1MFNPQUI1b3diams2UG04TDl4Q3VOdWhWVFcvMXlm?=
 =?utf-8?B?UHBEVjFRWmxieGVwampZdlE3Zy9qL2pJamZjemZOcnNmeFRIUUh6K21WalZQ?=
 =?utf-8?B?UzFWaGplSzNlZDN4ZloySHVBVXVua09tV2s3Y05RS0ZJbW0zSFlHVzAyMWZh?=
 =?utf-8?B?TWVBTXgzdGRhWXNrSDNuaVJXNmJKenlzSkhaYWRoVGFZTnB0dHJhMWM0MEdu?=
 =?utf-8?B?QUNRNWVDb0pnVkhQQys5bGU3VDIzZWg1THI5T0tKeE5CbzNRRlp0U2hyZUFW?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F9AA6425DDC3E4A884229E624971C3A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebef8921-857c-42b4-8854-08da70ce02f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 19:18:54.1056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Q0pIEvD/uKujMSKWpU0bli3gfUyuZa71ZMDJKdAs8dU7F/4BdLvEIM3xbwlSSTqpbGusynkjSKiZxihKIt37uP5y3WFyIOeFlcwoepGw34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2278
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCk9uIDI4LzA3LzIwMjIgMTk6NDYsIEl2YW4gQm9ybnlha292IHdyb3RlOg0KPiBPbiBUaHUs
IEp1bCAyOCwgMjAyMiBhdCAwODo1MDoxM0FNICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
PiBBZGQgdGhlIG1pc3NpbmcgTU9EVUxFX0FVVEhPUiBlbnRyeSBmb3IgdGhlIE1pY3JvY2hpcCBz
cGktc2xhdmUgRlBHQQ0KPj4gcHJvZ3JhbW1pbmcgZHJpdmVyLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+
ICBkcml2ZXJzL2ZwZ2EvbWljcm9jaGlwLXNwaS5jIHwgMSArDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9taWNyb2No
aXAtc3BpLmMgYi9kcml2ZXJzL2ZwZ2EvbWljcm9jaGlwLXNwaS5jDQo+PiBpbmRleCBiZDI4NGM3
YjhkYzkuLjc0MzY5NzZlYTkwNCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZnBnYS9taWNyb2No
aXAtc3BpLmMNCj4+ICsrKyBiL2RyaXZlcnMvZnBnYS9taWNyb2NoaXAtc3BpLmMNCj4+IEBAIC0z
OTUsNCArMzk1LDUgQEAgc3RhdGljIHN0cnVjdCBzcGlfZHJpdmVyIG1wZl9kcml2ZXIgPSB7DQo+
PiAgbW9kdWxlX3NwaV9kcml2ZXIobXBmX2RyaXZlcik7DQo+PiAgDQo+PiAgTU9EVUxFX0RFU0NS
SVBUSU9OKCJNaWNyb2NoaXAgUG9sYXJmaXJlIFNQSSBGUEdBIE1hbmFnZXIiKTsNCj4+ICtNT0RV
TEVfQVVUSE9SKCJJdmFuIEJvcm55YWtvdiA8aS5ib3JueWFrb3ZAbWV0cm90ZWsucnU+Iik7DQo+
PiAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPj4gLS0gDQo+PiAyLjM2LjENCj4+DQo+IA0KPiBB
Y2tlZC1ieTogSXZhbiBCb3JueWFrb3YgPGkuYm9ybnlha292QG1ldHJvdGVrLnJ1Pg0KPiANCj4g
WWV0LCBJJ20gd29uZGVyaW5nIGluIHdoYXQgc2l0dWF0aW9ucyBNT0RVTEVfQVVUSE9SIGlzIG5l
ZWRlZD8gSSd2ZQ0KPiBzdWJtaXR0ZWQgYSBjb3VwbGUgb2Ygb3RoZXIgZHJpdmVycyB3aXRob3V0
IGl0LCBzaG91bGQgSSBmaXggdGhlbT8NCj4gDQoNCkl0J2xsIHNob3cgdXAgaW4gbW9kaW5mby4g
SSBkb24ndCB0aGluayBpdCdzIGEgYmlnIGRlYWwgdGhvdWdoLg0KL3NocnVnDQpDb25vci4NCg==
