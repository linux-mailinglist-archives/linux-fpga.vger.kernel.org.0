Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C174D9AB0
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Mar 2022 12:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbiCOLxR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Mar 2022 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbiCOLxP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Mar 2022 07:53:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0850B02;
        Tue, 15 Mar 2022 04:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL04tixjZv86OOZDp1ntjvWmr639vlzrb+vRRpegc7JiaeDlANZR+5Hs8FOkyYvuNZaYCQjjjN0/bls3+s5PcY0o9eiUMCAlHSGZgV1lizDdEtDLstHAlC5lGi0JPcQdQMna3d1Q0zXDtVN7xOmqmDzHogFdNLbBkvivUMl4H5DeD8SSh6VcxNiowQc/LUJX6ugLxELkaGJHdW4ZcEv3H6fxvEzvt0DXwbwojNsMgMIsLSGPiyohuiVjYmW88bHjXBBoGkxI+F29kAfff3RHtI9hhFKRfyl7w/QSdRTRUZW1A/U7qM9TB6envbWFfnA2ZRgLBlQm0iXtY9DDTPnGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOugACYkIamtdqXQpETC1XQDstke7vhzmQYJ3FwVzMI=;
 b=Vcak0rn5KnwFN30NsgxtKwKPU4jXvB4vlq44TbpJIOKTwl5gUn78VbPMSNLYpZJYwVupbt6dxi+5Zh1hiL7Grh/BToA6ac1Tpg0JERWmuBMgvh0aCZPWBRJLLFe7uBSzCAkPcnjkww7xIm+Th8ahay8qfdS0tnXnAdIZdPoZmvMf6Futk3rSgqS+8FnBK4w28AUai/z+URu06t9qC5pTSr/RDuabtkqUMDNkfAv9ZXli5XEmYgv2hP5el9KCtHg4nqpx1dEqIs0112fxxZO76QqB5qnfp0WGIDGYuWdxZ135kn0lnnw6ZHMfrlScgv/JU+TlOogkQ9xEr1KkAQmHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOugACYkIamtdqXQpETC1XQDstke7vhzmQYJ3FwVzMI=;
 b=f95VkS2hXVW281v/8WXTRWsjj6x9NxEub7pyL2R9rR5i9XjcQY4TVyrGxoSyF380iQuTiLmRgpU6S1r3YlNZYAspeMrSQCksoVQz67onCxsGrFXb6E0cZhmuorGYbok6exT679sFM+9+l8AnKOd9jnzHFMgAEVHb3gXxrLFCS0Q=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BN6PR02MB3380.namprd02.prod.outlook.com (2603:10b6:405:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 11:51:57 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 11:51:57 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 4/6] fpga: fpga-mgr: Add missing kernel-doc description
Thread-Topic: [PATCH 4/6] fpga: fpga-mgr: Add missing kernel-doc description
Thread-Index: AQHYMtFhCIQnX+bfUEG2UlLZbZNrSqy2BCOAgApbppA=
Date:   Tue, 15 Mar 2022 11:51:57 +0000
Message-ID: <SN6PR02MB4576356531DD49BAF45FE28AC2109@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
 <20220308094519.1816649-5-nava.manne@xilinx.com>
 <f28c49a8-4e5a-5601-4d0b-05d34024779f@infradead.org>
In-Reply-To: <f28c49a8-4e5a-5601-4d0b-05d34024779f@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65244c45-6dfc-4796-c681-08da067a3547
x-ms-traffictypediagnostic: BN6PR02MB3380:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN6PR02MB338083CFC7F353E53BDA87D4C2109@BN6PR02MB3380.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFDMv/2U2MRlrlji8psVwk8KTTh5YBuV/57KT9w+aQIDfLEHm8y58HwQEjoBZ/bLcXR2tjDcufFP3QhQqxuWPgkZeJwfB8MSRr4aBD8cKsMC5FYGbiBTJyYANshTFIbw5X22iOgoBMeeNzsJN3M5mwff+Q7frudEYuz23JGHA3R0wvxxPUlRviUGxfcVC59eh924DFTrLenfkZJoOqsSuws5XW8t5ed6kPcyuYyWiuKsrk9VJJarMzfFXZsUgZPtf+lfvjDZOiJqO7Fp648Out3ZkAZI7aNoKajFBYvryS0uxXEGXX7TB4WLtuxhWD909fbOoD9+w1TGzrdqoWTGUgP7WdYx9MrF4HQzxFDuINmPmUF+aOJ6N4q252082DOlKuUZ6Ea+akAJ8wrkF6HpQUqB5MhaGkfQGoYaj4OJm8gy3ry4pF0gqLcifeB8qCMJqGAUHVj/To9v1NZrfq9JSZ8GNlTnOuUuUGuO+CJ6pbXbv7LyR5o7Zt6L4Er4jiX9GhQTQd3ShGf3lEia+GzTeSnd008jhL9jYDty1T7Nt2svqb+mDQLgacKBqGFPrFk34rjYQN8proDkNAnyGT9y+ya1GISmgCrgaUy0UfYAxJPjkU8PrZX6b5eDPnqxACFJvBihWMM+rwDRBv7ArblYUOtLNrcPDyIo4ZkW+CE2LHfmk3iOFWu1rVBahuqaRYQkIhCfy3seRgbCUGfKzoRyXnL3dqaH5cgqLnOk9Ov4wE8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(38070700005)(55016003)(122000001)(508600001)(110136005)(71200400001)(316002)(26005)(53546011)(186003)(7696005)(6506007)(83380400001)(9686003)(5660300002)(8936002)(52536014)(8676002)(64756008)(66446008)(66476007)(66556008)(2906002)(66946007)(76116006)(38100700002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVRWNUdXbTJQWGd2VDdINEErNDFKcmM2ODFVTDlUV1Bxc2NvcUFDYldsRk5w?=
 =?utf-8?B?dGhuL0toc1Jnc1BmbWltUWFwVmVjbEFYRFBpN0doejlKYTdYek95WldoNFFY?=
 =?utf-8?B?NWxOY24vaWVNS0lFSTMxQ2d6THdPeTZ4cGM0R3pseWkwSGpwMUl3RVpMRElm?=
 =?utf-8?B?SXU0UzI3Y01PbnBjbVp6YkFmZDhQcDN5bVFjVjhGKzUxNkltT2wrZUVEOHc4?=
 =?utf-8?B?ckRlZU5ZQ1JhOE5POUdRMU9LNDI5VlJOOCt5TDR5UEV5MStRNzRocVpyTUti?=
 =?utf-8?B?cHk0eXNvQkF4Z3lzL3Q5NXZqaU85YmRNT1daREZ4MDhYL29Iby9MWGRSTENF?=
 =?utf-8?B?UzV3b0VwbGR4WitRWmdnR2toWExhNXdGMllCRXlBM3NEZnlyZG9JYXZzVStG?=
 =?utf-8?B?cVVVWlBZbUF6aGZ6WGVpZTdyMVpwcEpZV1lnSUlJNEIzRDRJM2MyUXJzaEY5?=
 =?utf-8?B?RkhuZGZyT1czZTBZcjVKc0NyNEZMRnIxSHVqejloWURhWE5tWmhSeGloVS8v?=
 =?utf-8?B?KzRRVFlpVzcwVGdTd0xTQzlJanNEcG1tMEovRVlXUzBFZEpUU3ZMODFqbUl3?=
 =?utf-8?B?UXZrOWpmeUQzMVVXN0E1UUxsbi85TVJXMGZwb0x1dG5hRTB2WHVyWm1SbjJq?=
 =?utf-8?B?SCtMZ3JEaEM0QWF4azI3Qjh4RUJIQTFuN1NuMnhXRnQvNVpQQnp3TlU4Qjdz?=
 =?utf-8?B?SktoZmU1c2wvNDFYTEJUZ244QTIyR1A4VW8wQi9lZmt4OWNVVkFiNXFDUXFz?=
 =?utf-8?B?U3pGdlVGM1VOako5MGtjRERNUDc5aml2cnhqeWRZb0doSkVBOGFPYTZHNzFs?=
 =?utf-8?B?azF2dWJyaU40YWlWdFFLVkM4SVN1cjg4djRSaUpJNWdWVFdEZGV5YS9GTFE4?=
 =?utf-8?B?ZThHN0RBcnN0aVBJcGRQSnRMSUF5K1Y2OVM2QlNKeHJZZTlVNjNpbHZuVXZt?=
 =?utf-8?B?d0hIOFNWUHhHVkZydVF4N2huQWcwKzlUYjc1RlNRb2x4MGhFUHI4c2FhVnhG?=
 =?utf-8?B?UkJqNFNxbDFsYVZqMXhiRUlZc3VaN0ZHV3lMc1lwQkZWS2xpNE82VUM2Y0tx?=
 =?utf-8?B?QngwSko0NklHSU5XL2diL1VHNGVSakhaSnVQRVY5NkR2cEVxOW8zTmdRT1Zr?=
 =?utf-8?B?L09McDFIbWprSVljRHhpNjdjbW9pVVh3bzJ5T3N0b1c1d3UxY0ZFbjRQc01M?=
 =?utf-8?B?YmN4WURKemY2aUt0QW5yRDZYTFU5NWdhTVVHRGJLQmRsU2NudGZUVEQwWDBw?=
 =?utf-8?B?Q3g0ODA5dElLYnV4V2w0RGU1WTF0MzVOa2ljcmgxMkpZcHJXQ3JLSFFYSVAx?=
 =?utf-8?B?M2YwWDVleGM1MzJUbHdzcFpPc2V3V3hIZlQ1WjJhTjJJdEs3TEU0WnBnZVhH?=
 =?utf-8?B?YTR2WjBKbDZPN2ZncVIveVQzOFJJSnpJczZjbkhFU0tQa21BNWlNaXd3K0N4?=
 =?utf-8?B?cDliTzJjQkhJb2hhRllHTzRDUVZNcGNuSDhmWTZPMXhnR2ZZdjlSakhUa1hC?=
 =?utf-8?B?c0kwbGlUZGwwdVVENmlKdDR3NFh6MHBoY1lsWDFjL29uaTdGV3dJdEN1Mitp?=
 =?utf-8?B?bHRMS1Y3SjBPK2ozQzR2am1kcUdmNkxjM1pOS20xOUw1Vkh0U0wvYWRsMC9R?=
 =?utf-8?B?azVXSUtVMkZobmRMNFpDOFYyYzhpa2tEM2dDbHV6c3NSSllDd3ZKV2laSnVT?=
 =?utf-8?B?YXIyeHo4SUtaRUl1VFIxVXhNenhJdWg2NzV0czh2VTBLbXhvK3lHYy8zRXJG?=
 =?utf-8?B?YTVqc2FkMVJpcmExRVRjNVhGZURXbzIraHNGR1J6dml5MHl3UDhiMFV2bThV?=
 =?utf-8?B?THIraUkrdHpGN0pwcHBVQUVHUE95b1BqTVozMm51OGZYSm9ZdldrSDdScUpx?=
 =?utf-8?B?S2tOMU1wNWIxK25mQk05cVZ6ZDVxbVJ5TEJTN2JSU3czNG5kZS9XYmhRK3Vt?=
 =?utf-8?Q?+THEm8H4FSvu3klqSqHNZnt5kKWp08k7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65244c45-6dfc-4796-c681-08da067a3547
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 11:51:57.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yUYy1aZ2IJVvsJDwMZPxg2fXq98TqiyKBgQz8rU55W1V0EGzAWbunyTvk0Bs7trShpT1IWCVEU8tOCVFAGyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3380
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgUmFuZHksDQoNCglUaGFua3MgZm9yIHByb3ZpZGluZyB0aGUgcmV2aWV3IGNvbW1lbnRzLg0K
UGxlYXNlIGZpbmQgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBTZW50
OiBXZWRuZXNkYXksIE1hcmNoIDksIDIwMjIgMzowOSBBTQ0KPiBUbzogTmF2YSBraXNob3JlIE1h
bm5lIDxuYXZhbUB4aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmc7DQo+IGhhby53dUBpbnRlbC5j
b207IHlpbHVuLnh1QGludGVsLmNvbTsgdHJpeEByZWRoYXQuY29tOyBNaWNoYWwgU2ltZWsNCj4g
PG1pY2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC82XSBmcGdhOiBmcGdhLW1ncjogQWRkIG1p
c3Npbmcga2VybmVsLWRvYyBkZXNjcmlwdGlvbg0KPiANCj4gSGktLQ0KPiANCj4gT24gMy84LzIy
IDAxOjQ1LCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6DQo+ID4gRml4ZWQgdGhlIHdhcm5pbmdz
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICd4eHgnIG5vdCBkZXNjcmliZWQuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmEubWFubmVAeGlsaW54
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9mcGdhL2ZwZ2EtbWdyLmMgfCA0ICsrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZnBnYS9mcGdhLW1nci5jIGIvZHJpdmVycy9mcGdhL2ZwZ2EtbWdyLmMgaW5kZXgN
Cj4gPiBhNjk5Y2M4ZTJmYTYuLjM1NDc4OTc0MDUyOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2ZwZ2EvZnBnYS1tZ3IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZnBnYS9mcGdhLW1nci5jDQo+ID4g
QEAgLTczMCw2ICs3MzAsOCBAQCBzdGF0aWMgdm9pZCBkZXZtX2ZwZ2FfbWdyX3VucmVnaXN0ZXIo
c3RydWN0DQo+IGRldmljZSAqZGV2LCB2b2lkICpyZXMpDQo+ID4gICAqIEBwYXJlbnQ6CWZwZ2Eg
bWFuYWdlciBkZXZpY2UgZnJvbSBwZGV2DQo+ID4gICAqIEBpbmZvOglwYXJhbWV0ZXJzIGZvciBm
cGdhIG1hbmFnZXINCj4gPiAgICoNCj4gPiArICogQHJldHVybjogIGZwZ2EgbWFuYWdlciBwb2lu
dGVyIG9uIHN1Y2Nlc3MsIG5lZ2F0aXZlIGVycm9yIGNvZGUNCj4gb3RoZXJ3aXNlLg0KPiANCj4g
Tm90IHF1aXRlLiBTaG91bGQgYmU6DQo+IA0KPiAgKiBSZXR1cm46IGZvbyBiYXIgYmxhaA0KPiAN
Cg0KV2lsbCBmaXggaW4gdjINCg0KPiA+ICsgKg0KPiA+ICAgKiBUaGlzIGlzIHRoZSBkZXZyZXMg
dmFyaWFudCBvZiBmcGdhX21ncl9yZWdpc3Rlcl9mdWxsKCkgZm9yIHdoaWNoIHRoZQ0KPiB1bnJl
Z2lzdGVyDQo+ID4gICAqIGZ1bmN0aW9uIHdpbGwgYmUgY2FsbGVkIGF1dG9tYXRpY2FsbHkgd2hl
biB0aGUgbWFuYWdpbmcgZGV2aWNlIGlzDQo+IGRldGFjaGVkLg0KPiA+ICAgKi8NCj4gPiBAQCAt
NzYzLDYgKzc2NSw4IEBADQo+IEVYUE9SVF9TWU1CT0xfR1BMKGRldm1fZnBnYV9tZ3JfcmVnaXN0
ZXJfZnVsbCk7DQo+ID4gICAqIEBtb3BzOglwb2ludGVyIHRvIHN0cnVjdHVyZSBvZiBmcGdhIG1h
bmFnZXIgb3BzDQo+ID4gICAqIEBwcml2OglmcGdhIG1hbmFnZXIgcHJpdmF0ZSBkYXRhDQo+ID4g
ICAqDQo+ID4gKyAqIEByZXR1cm46ICBmcGdhIG1hbmFnZXIgcG9pbnRlciBvbiBzdWNjZXNzLCBu
ZWdhdGl2ZSBlcnJvciBjb2RlDQo+IG90aGVyd2lzZS4NCj4gDQo+IGRpdHRvLg0KPiANCg0KV2ls
bCBmaXggaW4gdjIuDQoNClJlZ2FyZHMsDQpOYXZha2lzaG9yZS4NCg==
