Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F78B4EF7CC
	for <lists+linux-fpga@lfdr.de>; Fri,  1 Apr 2022 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbiDAQV2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 1 Apr 2022 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354714AbiDAQUm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 1 Apr 2022 12:20:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A270D1D67CC;
        Fri,  1 Apr 2022 08:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO9dPmcVmwBjx0QCh1J59Lt2QpM0E6JAe9QVx0ZRg0ptl07MIRiEFWJfP2NBwYqfQcmVa14ZYhT74SU0uJvXfKdRPeO+2I2b8EiOnE9npE2XMciBXu4a9/jNqc3aATBk/u1ZF41G+X2GHwLI8utFH/v0RkLiqke3l7RrOSVXgec7dns/aPlkjiTBM+/6FPUTfjixNimGCbvVlr0cqjd5EX69GFOmYxgeazPozWbemzsC0pqzGVA7XL1CALedt7pN5GYDzBaDRnK+HhrYutJuJrRTtcT9tsFQO5W2hi4Y55ki65NXPi+ClxdLARp+1+pZ8qMJ4UKjAFsFaD3GqO/Vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl276uNGeuOPSBCVspRuqSSAq/A0E68GnGirArUpYe0=;
 b=hkHPf6ZbeTjKgIbMNZvOU9CoODxVvNwYAa1n0ZjGa3FfgbD2w04cBVgZZHXndPd7g2yy04xrgSTpcF4PAP85hoHA05gMFpM+4Iju1jOPffw/5/1+uBKZxrehJyEEiHgQEEkpEPFN6jP09YQpB0NiC5pmImpjIt1lhhZ7Pj16kNNL1KH0LKK6FNZCgz5u1uAshAqM/nSeV8iy0qTGZdvxj9WV46EiXHXOZ7Ptz8aAKCKBUWGaWWGjNrnZU8kdk/lt487WVkgwtc33sELb95q2dQ5cXaHwPp5xZTVBKT+9203YCyPC9Fb1U3pujRQIYx0e9soadwvsqauFBDsyvNwFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl276uNGeuOPSBCVspRuqSSAq/A0E68GnGirArUpYe0=;
 b=FWC0ugDXE6aFAc6AeRDZMg+ekBjvGG+DaY9uHqgvKuDwKVfjgPfHfBGrbVPY/QOXE57421JOsJX/Dhq1r2mHeC/e5A7AXUm47KIN7zzwTC2mtpzKDwAlSGhegwM7xyoc7nZ/4/GcZEgmEER7ZY8vzrchPX+q7qHLViOvhj+yryk=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by MW4PR02MB7267.namprd02.prod.outlook.com (2603:10b6:303:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 15:47:28 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd%6]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 15:47:28 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v2 2/5] fpga: fpga-mgr: fix for coding style issues
Thread-Topic: [PATCH v2 2/5] fpga: fpga-mgr: fix for coding style issues
Thread-Index: AQHYPcX5tckskFUOtUSgFLK4auaM9qzR6y0AgAlYmRA=
Date:   Fri, 1 Apr 2022 15:47:27 +0000
Message-ID: <SN6PR02MB4576CFF0C10D232066F4E08EC2E09@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
 <20220322082202.2007321-3-nava.manne@xilinx.com>
 <8d6100a8-4c5f-20d9-6c94-f08379e989ec@redhat.com>
In-Reply-To: <8d6100a8-4c5f-20d9-6c94-f08379e989ec@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 499fee9f-45c2-41e6-86dc-08da13f6ecb1
x-ms-traffictypediagnostic: MW4PR02MB7267:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MW4PR02MB7267890A3B92C26C3ADCD5FDC2E09@MW4PR02MB7267.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+Q5uN6Du9aHwPnuzzcDRBIy39yDCe37wQ6ORfTlYpM+LgFIKlFZ0ln1ijkhVEo5lln2uG18lBX5+NuSmzDpofdMy6L1ZfzRcQoQYAgPVGn5VjL0oqeBeUZjfzM5mW6cmQ8RRiQNQwzwt1vqX0zSYnhSMNBiO+tZY3xRn39R3LnsMCMQ3+1VBxsQdwQx8bxTPADQDaLIXn3U84iIasRVSTsKYAurp9PrhaSf13rb9foSfL4VLoXYLOSijMrUX9nWdVfIodfXaFDQyaqi3bDhD4bAlfpZGHOJrfDc7AFJ0ue5OdyJAoNLeYuyWqNbX1ZihxJtg1cwuzT0nnELSwN5zGyZCBgn2dQr4zATqC3XxaPtUdp4jYNzDvIEq5Dv2IRuYFZ6EVywPetTRGMkwqEDLBFWNNVG0IS8B+rAFr2SjpoglrbxEYpD6rM9rsqGBYVYtifH7rprdAYmNpsZytBVQpG3s3DXcat7yvVgxH9IOUk7BMQkHhQEBx3ImV9gnCrc67L9DOQHLK88LG+zDni/mCaDCA1Qw20mBZKKHTGz1ptJjQWAZo+YBobiAkaTwG7Mn77goUKqbGp7EfrtjsbPy0z/fLYbC9Qcy+OaAHd6KTM4SBnDY90hAncB/ByI4/kMhtACsOqCPg+M0uaiZfR6s5b2MvgFo6FHIBqHCUxXCRU0x9e8ONNwgprU2+uv1GA7VrCV5LNgwtvTEmMuyV60RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(122000001)(52536014)(316002)(38070700005)(6636002)(26005)(186003)(508600001)(8936002)(83380400001)(4744005)(5660300002)(33656002)(66556008)(86362001)(55016003)(38100700002)(110136005)(53546011)(66476007)(7696005)(66946007)(8676002)(64756008)(76116006)(2906002)(66446008)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJIRXNjSFRTbU5OaGNYSzZDd1hIWjcyQUl1TndJdkdBbHR2V0ZUN043SXUr?=
 =?utf-8?B?YlRJUlJQTXQrc3Fxcm9TeU43Z2RCemM1U0JUdCtLd1R5am9RV2tZZGpJNUhl?=
 =?utf-8?B?dUMrb0R5WUZTZ09rTGxZK05iclptRnh4K0pRb20xbFh4aVlyeGYxY282YnJa?=
 =?utf-8?B?bVQ5Rm0zR2dmM3haMVJGOFdMa3FRZm1jVVpGMUhqQ2M1UnRxN3k4T1NJaWs5?=
 =?utf-8?B?RzFnVlBmbDEzTzZYNzR2WjJFOW1lZ2lhM1h4OGI3VGZNQlFMemh2MzVHdFJm?=
 =?utf-8?B?M2tIdWEzMjMrMUJmK3U5MzNaNGhFUEhkQ3NWazRrdnVnc1o4MkF4N1p1UmZ6?=
 =?utf-8?B?NVFwbFVLNzNWWk5iSU1IWGYycDl2N2YrR1A5dlJSampRTkNlTkVCWFZBZzda?=
 =?utf-8?B?WFI4UVZEOWk4Z0VNVnVpbmZ5SDVnOU41dmhVOWxhYmlaM1RZMkVIN1ZvYjNK?=
 =?utf-8?B?NEEwQnZveDNxTEltVjBxb0RKVEt6cXZXZHo4dW1VaWxMMkVGWUNjWEk5NUE3?=
 =?utf-8?B?emJtcWMxYzdnNVZ4RzZCTzFYeVAyMFcvdEluNS9oRlNia1ovdWdOTzZqWUNW?=
 =?utf-8?B?RWlqbVp1V1RRMjRMcGJrZytBQ053bkQycXVia1hyUUZnYzJEaEt4c0hXWjl1?=
 =?utf-8?B?aXYraU1sUWtuT0YxM2YySmExK3ZHS3BCTmJUYmJqRDlxMFNjNDdhV2pxdnhr?=
 =?utf-8?B?SHhUSlQ3MHVwcTVLb01qN29SSE4zZGRaOHV1VWd5djViSjhQY3AyWkhCcmZw?=
 =?utf-8?B?bnQ2QTY5dkpZUlo1T1M4TGhOeXNSdHYrMmkzZDcwc05EYjRMMXIzQkc4YUJn?=
 =?utf-8?B?YytMbWNBbWp1SXZBbkdlY1V1Z0l3R3F5eVIwNmI1MmFZNU1BbzA0Z09tS0Yv?=
 =?utf-8?B?ODQzZXpGQk5Uc3lLQlBKVXFTaWtuNitVNUMyTUhqbFdsM2x6Vm44c0JOMlZX?=
 =?utf-8?B?N3NlcUExUlhUTU1WbGoxNFAyaDk3VWxPQVpQK25xaW1KZThRcFNlYVR2STZk?=
 =?utf-8?B?VGRJWEcrbjRMKzlDcEEzNE9aWDZHYkFjVWMxc1pOOGZwVkJ5eEF3SCt3YXdR?=
 =?utf-8?B?bW9wbkFra3QyaWU2dFpNTVNaNUYyaXgrZ3F6dFJad2plbTVhS3FLbWMvK2Zn?=
 =?utf-8?B?b2g3ekRNY3kwVE5pdFNOYUcyTG1nYXdkR3c4dStCNllLR0ZxcWZpcHk4L2NU?=
 =?utf-8?B?U3VkN21XbmRkeDVGVExXMTdIOU1qeDVQWGZnV1ZiUzU0VEdTQkYzbytkcUo2?=
 =?utf-8?B?WlZjdE9ETTdRcHJwZHE3Z2JZY1o5MW8zTkRPZHQrTVZnTS9xY1M2Uk94czAr?=
 =?utf-8?B?YXB1b1Nlc284ZFpEK3Nzb2sxOXRKdG0xZlJqczR6UmgxV1NZbm1oTzlHQ0R0?=
 =?utf-8?B?MUdUaHNXaWxRMkpoN3dJeStNWHhlNXdNZElLcFlteTZCZS9QNEQ4ZjJqZDBT?=
 =?utf-8?B?akJzOC9ZdUJLa2txU1VzSm9sSmgwcXhyYWUzR0wyR0lOS2RkV2RBbWtZUWFU?=
 =?utf-8?B?TndZV0VDa0Zuem9ad1E2Q0VGYWhBeUlvbWM3blVJQ2p0OHhZMTE3U1N5NUQ2?=
 =?utf-8?B?cDhrbzcwR2J6R3lQWkdyeGRGdFFPNHF0S2hjWHM4MWwyRDU2Z3lzYWFDU0lZ?=
 =?utf-8?B?RkgwR1hEWXczNE9hUlY1b0dMb2g1eFpTcHRBazJVWkYxaUtQWmVhYUsyalRF?=
 =?utf-8?B?Z0hXcC9RRGdTYjlkSmdZQUtPSTZHZTF3NDJOOHBNMC9CbWtNQVBKYWtCaGcy?=
 =?utf-8?B?cmJiaDVaSHRXSzR2dlRXbkIyV2t6RldKK0lFVFFRcVhvU2c5TDAwY3pFR3Jv?=
 =?utf-8?B?K0lFbG9Ub002Y0RkS3FzdUFGaGlZOE1pU0o1V3g5SFFXakNRTkl2cytqNGJC?=
 =?utf-8?B?SW91TjhIdS9wR3dYdVYyZlIxUVpDVytCczhkYVN0eG5tM3pEcG9oRG03Rkxx?=
 =?utf-8?B?NTZ5N1NjZS9mYTlXRmxpaUNHZ1RGdFd5RlY5c1VlUWp5L3FOTGNhUWdFUzRX?=
 =?utf-8?B?TlE5Z0lSQ3c1ZDUyZ0s4R2NaeE1UTFFKeWlVLzZXWlJST2dzNzlsWE5jUzla?=
 =?utf-8?B?UWJ4SysvRG44TmxzNnV3azFUYU9tZ2FqSjZTMzVwZ21NUUN1NEFxU0JRUXZv?=
 =?utf-8?B?TU5CSHJIMTBqcjdoaUxEa09hd043cDhFbng4ckZaNnl4YWJGbTVCcEZDMnE3?=
 =?utf-8?B?WE95K0FGM2N0NEhDNmozYnVMMTRZbmM5Nm5ZYVNnbWpjZDkvcm1vNitWbFVJ?=
 =?utf-8?B?QmtOUnZyRnZjeFBwRUIrVkYvbVJMczhqcUNvK1NyR3pXMERlaDBuYkhXc1Vx?=
 =?utf-8?B?bHRqcWsvVDZ2VEJhblh2TUV3YXVPRGtIaTlQZlk5eTRSMUR5NHFhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499fee9f-45c2-41e6-86dc-08da13f6ecb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 15:47:27.9505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D86KpPN6mQxoQEKVterqRJyGNGHvZfb+2AVSI0Q0goV2949ooE4v2LNxDNNB3U1+gyglVYmR8be10RWd+/XKKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7267
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLA0KDQoJVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIHJldmlldyBjb21tZW50cy4NClBs
ZWFzZSBmaW5kIG15IHJlc3BvbnNlIGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5
LCBNYXJjaCAyNiwgMjAyMiAxMDozMyBQTQ0KPiBUbzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZh
bUB4aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmc7DQo+IGhhby53dUBpbnRlbC5jb207IHlpbHVu
Lnh1QGludGVsLmNvbTsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBsaW51
eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZ2l0DQo+IDxnaXRAeGlsaW54
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzVdIGZwZ2E6IGZwZ2EtbWdyOiBmaXgg
Zm9yIGNvZGluZyBzdHlsZSBpc3N1ZXMNCj4gDQo+IA0KPiBPbiAzLzIyLzIyIDE6MjEgQU0sIE5h
dmEga2lzaG9yZSBNYW5uZSB3cm90ZToNCj4gPiBmaXhlcyB0aGUgYmVsb3cgY2hlY2tzIHJlcG9y
dGVkIGJ5IGNoZWNrcGF0Y2gucGwgTGluZXMgc2hvdWxkIG5vdCBlbmQNCj4gPiB3aXRoIGEgJygn
DQo+ID4gQWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVudGhlc2lzDQo+IA0KPiBUaGVy
ZSBhcmUgbW9yZSB0aGFuIGEgZmV3IHNpbWlsYXIgYWxpZ25tZW50cyB0byBjbGVhbiB1cCBpbiBk
cml2ZXJzL2ZwZ2ENCj4gDQo+IEluc3RlYWQgb2YganVzdCBvbmUsIGluIGEgc2VwYXJhdGUgcGF0
Y2hzZXQsIGNsZWFuIHVwIGFsbCBvZiB0aGVtLg0KPiANCldpbGwgZml4IGluIHYzLg0KDQpSZWdh
cmRzLA0KTmF2YWtpc2hvcmUuDQo=
