Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11854D7995
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Mar 2022 04:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiCNDKN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 23:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCNDKM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 23:10:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D83EABC
        for <linux-fpga@vger.kernel.org>; Sun, 13 Mar 2022 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647227342; x=1678763342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKKZqjM/zdtiAq/f9B5u0qVBNq2Ivosrc0o/JO9a7yM=;
  b=SykUgSRn8pFxNphECq36Ot8j0hm+lFRwlmSEhtfi8WbCT4I0Wr/DzS6m
   VbB9IVacwfvS5Xb7g53Zt5+5kM2MkQdbNiE98ccFA1NMKo15JU605Glkh
   AaI1CRPxtWD+5BazWpbNMsjgybQ0gVjlUL2Li1fzR+BiDbaKPI9H97UyW
   yf+xMV1kfWWp8gur6owCBt7aF8MgII2fVpoPVsYuaCJ6CTqraxEyFk340
   eZ06p8M4RjMa8xrSVmlAjE2nzq3XjjxTB/Oiy2AvB55Q3zMfk86zM2UY9
   kixeOmWzQedjHCNzdSGVbJ93qJ9yd2KVQdVPsu47L8c1QINzGoodVOWXV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="253484430"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="253484430"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 20:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="597730542"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2022 20:09:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 13 Mar 2022 20:09:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sun, 13 Mar 2022 20:09:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Sun, 13 Mar 2022 20:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxlYt6k74utDssdcGU8gB0Dts0dxox0jaFSgsNf0GpTo2WFvRlT3WfHttC/UcdaC0X613RjKMc6xImLaFZNkx1CLiNH+w8ofKQYrhq3ciLS9Y22wIjUcRCwJHDevW4dE/LSgsVKdyFNjxZTaUv1Ljw1cQg+SAjoDWjTLfQ5z2mAtItB+jBgO64V/8B46bwaJlZTQoB/JDzV98IOnfV1FXVN6PKVUSwSY6STsBha2G/Ia0BS3ix8MkVH0B2PDOVAHw6N3QixEFuLgWWFiuYeKhvvMLLwMJJDOyMhVZenTsVXl4hrZ7KVTgquDvX8ouWIJlwgoKBdZ/ZszyZXG0N8eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKKZqjM/zdtiAq/f9B5u0qVBNq2Ivosrc0o/JO9a7yM=;
 b=kiZs/s4Sa5IzNMQLICzZWDYNtcRAB+cbEMH3sj0AOE885Yoazru53W+KDSrtdMjqnT2c1bOcl5hEb3siPzutoPBLXBcKlS0RcUTHqNy704q3yiklLjJBBilBR2/hDZGF96nr5BIT5nakCgFkwtgZfQ6yrSBR1Jkumd8M7d0SbGlYa5+zOzXnE8S9+F3+ULlEmeabEoNa5GZanMjuW/tVgfunLNgXAxB/Ou6KE2Er8ztIcuvrLSEru9Q3nI3P6vAZj/VdfrzhXXKPS453VkJgDIuqRZMq5dYJTUpLzM0LMIwZxuQh+YPnWgC7MHjFkSY+A8V8dnwZi7r2kCXRkMH6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3915.namprd11.prod.outlook.com (2603:10b6:5:19c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 03:08:56 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 03:08:56 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Index: AQHYNLWszaqWHWDC/E+0/e+KE1p1U6y5ZyLggABOFgCABIET0A==
Date:   Mon, 14 Mar 2022 03:08:55 +0000
Message-ID: <DM6PR11MB3819715B8A7DF03DDD19F7E9850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
 <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c614485-b9df-4d93-3d0d-08da0567fa08
x-ms-traffictypediagnostic: DM6PR11MB3915:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB39153D7E8C792B13AFF2A63B850F9@DM6PR11MB3915.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7lK2aH537HkAuLGyFc8PXR/vk4HhUXx8I0fmycRPus7V0jUIKabhDfnV5NP1EmF9YcwACkzYhHSsD4c2lUrTR319o3s+46Lw0dZ1iyauqqOPWHJMcfe8YSlMJnHtkpT6C5gtfYIa2Xw5hF2kuu2JYxeD6MqXOrAja/66cFZpJbB8I331Z6WUynljl9O/81t1QB+luT415utE4AE6S2qP/9Pv3JWbisXbBbDLLgmn5Ufnog5IiMKV1zxZ8z1dCcL5YnJYV/9w4oD+iKMNDs+vx47XqmTqniegDRcGvKHeNJ3boNe+Pxa4srIF9j0VkFMxUGiMLjNCv1sxo8DFgHpvMHD2MGZdBkyce9AEFxenJglD3Lp+oMUW6ZOmBgwCTqMBs1HXyti27dtThHt9wjZ7lFNOx8pkHuJOZtm+In3mLxmrwqqaKneNlMfaGkkc6u0568Bc/+kRUCKx136WLWVvstx3cYSqk4mGZC898UMl+hq3nQzY1ycK7KiP/QEQgi8s5g5dLB1Qgp18mfUPFob8sBO6d6k1QZc3asKoNJtZ1Ea5f7vIgLO9uGkjmW/TqT3HUHie0u/E63SBWf1hNXWYXgoeDahz8fF7zLEuba2jnhBWuzMrzugiGiFJ67DPeBIuJKLU8PGCc6rWi5Pl7VUlAKWFiw3sGZxqFMtY2aUOLLr3wdFE/Wnw57b67znYIIrf6nthExcjOn6r3o6sBOrP4spvd/DcC8mXhMGkdtZRhuitIE7UVijpyDx5cQbbfRVYfC/pCy0Ce2XhaFLJ0L26swqOd7VWwJw2USzcWbb05WM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(76116006)(186003)(8676002)(82960400001)(66476007)(66556008)(4326008)(64756008)(66946007)(53546011)(66446008)(38100700002)(52536014)(71200400001)(8936002)(38070700005)(966005)(110136005)(508600001)(54906003)(6506007)(7696005)(86362001)(316002)(55016003)(5660300002)(9686003)(122000001)(33656002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEM3ZzBIZGVuU2g1RW1tY2NEM2ZUNGJsTUQydjNIUmtGd0ZYdDZuOGxuL25x?=
 =?utf-8?B?NlVJVmFHeExPUlZhdXFjazNIY3lJcGRacW5GY3ZlZXJJaSttOFFsS3d4YmZS?=
 =?utf-8?B?SUFTaHBYd0s3MXpMMkNpTnQwb3dVUXlHbFB2cVIvcmhvcThCeU9XVDZBSU5M?=
 =?utf-8?B?cFduNUF6U2g3WFZLQ1ZqSXBkbjdVSkFLUVArMy9vQTNpTjBzRElhTWNaYUpH?=
 =?utf-8?B?eXQ5UlUrK3dSNVpyRkZtZ21jMU9OMHkxU0dsb01CZysxQm5HUHRkSjNvVFR5?=
 =?utf-8?B?VURCbFVFOGt1ZXNlT2VCOGhrakhpNVEzY3E2c2UvV1lyTkhNQlJQYUlyS0lq?=
 =?utf-8?B?Z3VjdGM1NE5VdDFHOHcza1p4MmhvNFpWdE1mUm16Sk1sNU9lQnFzNXVxbzJS?=
 =?utf-8?B?TGFQVDczMDM4dlhoVWlZY2p1OXNjMWkvc3hsRTkrY3loT3FRa1MrSVJUSFds?=
 =?utf-8?B?WnVVdkNldURPdEF4OVplM3VwcVlnVndVeStpSGJvZU91cFZFRVo0cnhuSjNs?=
 =?utf-8?B?SThDOWZIWUhtTGQ2T1R4ZjFhSVJHeElpeVExTDR4MzEyRzBXTWtpbnFFbXg0?=
 =?utf-8?B?bENtT0NwcTlrYkhTWHA0NklaVzIySjUwWVhSK2k5b0tqU0pzcjF2cXNQT0Fn?=
 =?utf-8?B?bTZ6ZnFQdTJBMmFEYzExWXdiUmxJK1NIbDN5NEhoemgyWk1ReExBVWs4ZFpm?=
 =?utf-8?B?RFVoMzhrUHBoN2hObFUzMWNrdG1jVTdoWVU2MFJJMWMvQms3T3JSNjJIM2xw?=
 =?utf-8?B?RWlVTnlYczZhY1JGMFBoSzEwMVl1R00zMVF3YVlLTGNXL25uVDdpczNSSmk5?=
 =?utf-8?B?KzhHUnpjOHc2Tm1DSWpEVTFRbTMyREhWTSsvU1pnRk5MN3JENUNKTTE1T25n?=
 =?utf-8?B?Z01WOGhoOEJzRURqLzVsSkpDVUxWT2t0Sm41Uzhhc1V3NStYaXNnenA1dWRu?=
 =?utf-8?B?SUN1ZjFiOWRwK0p2N1JiNEVVZUpraDV3Ni9ZdDZLZkVuUkFDUVBDaUt1ZVo0?=
 =?utf-8?B?WVgvL2hIbTVsRWtzUTB6QmlOTGhpVjBpU1p3WUZ0blFoeFJsbk1KR1ByM0tO?=
 =?utf-8?B?aGlqaWdyQ2pLeFpnQnRrR3VXUW9WaHF2S05nYjluQmY5dytyR3V1enRKbGVV?=
 =?utf-8?B?VmtmMDVEcjkzajVDM25xNU1UQkxsMmE0V0JyTTF2ZWhBb2NOaUdyc1BkbUsz?=
 =?utf-8?B?czdVR3N6SnREQUNrWXQ4MUR4UHFqU3YrZEdjVjNCd3BXZWpJQ29YaEF5S2RG?=
 =?utf-8?B?aSt2cTNyQmpVbWFwbkVaTmRESEE1azNscHZqdGtOWGJpeXhyZFdoc2pXdEt4?=
 =?utf-8?B?a1NHcjdQaFB6TXBCUDVPeFpIR1ArR3NaS0M2T0xUOGxIaTNBdmtHTHovbFFh?=
 =?utf-8?B?Tm5saTgwOUdqVVI5QlB6RXlkam1KWXlEWFpSQndXaWw3Y1Vrd1UzTkFuRzMx?=
 =?utf-8?B?UVVMdzRWY2RBODQyank5V1MzY1hVdEI5STRQUnRYeXlxQVpsK0tMWi94QXZE?=
 =?utf-8?B?NnA5RlNlVEZZUzBEY0VYSGhmNkY5V1V0OHFNQUw5RTdqQnRzMzV1am9kcGZR?=
 =?utf-8?B?Y1hPOW11UXU1UUtVUWRVc016c2pxblZWdVU3SDhxc3RTTS9EY3dqbDQ1clJH?=
 =?utf-8?B?TmZzMnRtMUw4RTNCeDhGY1VkVFRKN3BXb2JDaXFJWFlYOTU0ZWlTaEU5MURt?=
 =?utf-8?B?U2UwUEtXL0xjaUhDcEhwZ0s2V2JRVmVHanZ2YzRZZ0R1djl5aUVkdkJoays5?=
 =?utf-8?B?enAzNjhySUpkaTI4VFl0TmdmL0JBVGlYSDVrZzlBelJ5YnRFTUdXOGtlSUYy?=
 =?utf-8?B?dkpRZU52Tm1UNklmSGV1UGVlK3R1Q1ArallyQXNFSHVRL2dYK28zNUh6U1Bx?=
 =?utf-8?B?VGZOZGhJdTBrRDlRZkswRFlURjBYYWt4TkIxWTFhbFlJZU9mb1B3OHpFd1RB?=
 =?utf-8?Q?ZS3/nU16pOc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c614485-b9df-4d93-3d0d-08da0567fa08
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 03:08:55.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtOy6Ms5F3UtfRf+1vbczyZZ2cYAkmjZt/N3QWlMHBz7Tq20P6vxccv04wXjPjgCIjgXcX5bir/Xl8ZkTsOTHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogV3UsIEhhbyA8aGFvLnd1
QGludGVsLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIE1hcmNoIDExLCAyMDIyIDEwOjQ3IEFNDQo+
ID4gVG86IFdlaWdodCwgUnVzc2VsbCBIIDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT47IFpo
YW5nLCBUaWFuZmVpDQo+ID4gPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgdHJpeEByZWRoYXQu
Y29tOyBtZGZAa2VybmVsLm9yZzsgbGludXgtDQo+ID4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4gQ2M6IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50
ZWwuY29tPjsgTWF0dGhldyBHZXJsYWNoDQo+ID4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRl
bC5jb20+DQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlvOiBkZmw6IGFkZCBIU1NJIGZl
YXR1cmUgaWQNCj4gPg0KPiA+ID4gT24gMy83LzIyIDIyOjQzLCBUaWFuZmVpIFpoYW5nIHdyb3Rl
Og0KPiA+ID4gPiBGcm9tOiBNYXR0aGV3IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5p
bnRlbC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEFkZCB0aGUgZmVhdHVyZSBpZCBvZiB0aGUgT0ZT
IEhpZ2ggU3BlZWQgU2VyaWFsIEludGVyZmFjZSBzdWJzeXN0ZW0NCj4gPiA+ID4gdG8gdGFibGUg
b2YgaWRzIHN1cHBvcnRlZCBieSB0aGUgdWlvX2RmbCBkcml2ZXIuDQo+ID4gPiA+DQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJsYWNoQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVGlhbmZlaSBaaGFuZyA8dGlhbmZlaS56
aGFuZ0BpbnRlbC5jb20+DQo+ID4gPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IFJ1c3MgV2VpZ2h0IDxy
dXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJz
L3Vpby91aW9fZGZsLmMgfCAyICsrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vpby91aW9fZGZs
LmMgYi9kcml2ZXJzL3Vpby91aW9fZGZsLmMgaW5kZXgNCj4gPiA+ID4gODljMGZjN2IwY2JjLi42
NjBlMWQwYmY2YjkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdWlvL3Vpb19kZmwuYw0K
PiA+ID4gPiArKysgYi9kcml2ZXJzL3Vpby91aW9fZGZsLmMNCj4gPiA+ID4gQEAgLTQ1LDkgKzQ1
LDExIEBAIHN0YXRpYyBpbnQgdWlvX2RmbF9wcm9iZShzdHJ1Y3QgZGZsX2RldmljZSAqZGRldikN
Cj4gPiA+ID4gfQ0KPiA+ID4gPg0KPiA+ID4gPiAgI2RlZmluZSBGTUVfRkVBVFVSRV9JRF9FVEhf
R1JPVVAJMHgxMA0KPiA+ID4gPiArI2RlZmluZSBGTUVfRkVBVFVSRV9JRF9PRlNfSFNTSQkJMHgx
NQ0KPiA+DQo+ID4gV2hlcmUgaXMgdGhlICJPRlMiIGNvbWluZyBmcm9tPyBpcyBpdCBmb3IgYWxs
IE9GUyBkZXZpY2Ugb3IgYSBzcGVjaWZpYyBjYXJkPw0KPiA+IEFueXdheSwgY291bGQgd2UgaGF2
ZSBhIG1hdGNoZWQgbmFtZSBwZXIgcHVibGljIHRhYmxlPw0KPiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS9PUEFFL2xpbnV4LWRmbC1mZWF0dXJlLWlkL2Jsb2IvbWFzdGVyL2RmbC1mZWF0dXJlLWlkcy5y
c3QNCj4gDQo+IFllcywgSSB0aGluayBhIG1hdGNoZWQgbmFtZSBvZiBwdWJsaWMgdGFibGUgd2ls
bCBiZSBiZXR0ZXIuIEhvdyBhYm91dCB0aGUgIg0KPiBGTUVfRkVBVFVSRV9JRF9IU1NJIj8NCg0K
Tm8uIFdlIGFscmVhZHkgaGF2ZSB0aGUgc2FtZSBuYW1lIGZvciBpZCAweDYgZGVmaW5lZCBpbiBk
cml2ZXJzL2ZwZ2EvZGZsLmgNCiNkZWZpbmUgRk1FX0ZFQVRVUkVfSURfSFNTSQkJMHg2DQoNCk5l
ZWQgYSBuZXcgbWF0Y2hlZCBuYW1lLg0KDQpIYW8NCg0KPiANCj4gPg0KPiA+IEhhbw0KPiA+DQo+
ID4gPiA+DQo+ID4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRmbF9kZXZpY2VfaWQgdWlvX2Rm
bF9pZHNbXSA9IHsNCj4gPiA+ID4gIAl7IEZNRV9JRCwgRk1FX0ZFQVRVUkVfSURfRVRIX0dST1VQ
IH0sDQo+ID4gPiA+ICsJeyBGTUVfSUQsIEZNRV9GRUFUVVJFX0lEX09GU19IU1NJIH0sDQo+ID4g
PiA+ICAJeyB9DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShkZmws
IHVpb19kZmxfaWRzKTsNCg0K
