Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9998F4C8115
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 03:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiCACfA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 21:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCACe7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 21:34:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC720F49;
        Mon, 28 Feb 2022 18:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646102059; x=1677638059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M8fhxo+UhhP6jGQQV8tPEEaSj/CaDfDdY9krnTx2hgU=;
  b=C4oRiJ9SA9NbfGWHi2LIFiYCw4OK7OS6pzzIFMTxV5nMVw5wgAWrHgzV
   aAA3PTSKFzSyFSUHRVL3twEqHIwnR/uI6WkFMDiAQHgrS0JSviqavYNdr
   b5OVT6ZtxXergUsFQr5+dkERFJeLCEFZ6KqCGf1tCyb/0DAqZcD0ZqN34
   Hzqz/2Rt/26AheuiLwpnc6tgXiRejgMHFuAaeCv7b+vkatA7QP3lXPxAR
   fventyO9b5O4V/VbPr4+yp80aYd6u509bpcinQKoDw8149WD8MYFiga+n
   iA2sy6FBMDiNabRTY9NMbSMaYWpJtTu4Vu6Uz8mALLynQGoWL0UzBw/Eu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250622100"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="250622100"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:34:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="492944897"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2022 18:34:18 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 18:34:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 18:34:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 18:34:17 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 18:34:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeEYYX0JfY1OYDFXWNGu8XcOtkgPgqWL7xaRCwpTBlIgyweKNNuH/RTzsWbs9j+zUGdXsfnbc4GwEc9v5OMuANVTsOgQzpCzY1i/7dWwSyheLlOd2iJuG+AIoiqLjAoA2/X6xikNX81zkOH91/ECneBZ4ic+iG+504kpFnY0ivoCmMtf5gQl4ivvQboJywmwV3fhfBVSncgxGa0F2uGusxiZr9NO1S4YLV01x0BseBHMradrY7bAHgi/RX2yt5DlrojH590uQNTPJWfts2jsrK0FA9PXLC2uMgcRuJgY8+xCnDFujZOm94Qx/iQnW/Mu43w2csVYtib+e9BfxBrdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8fhxo+UhhP6jGQQV8tPEEaSj/CaDfDdY9krnTx2hgU=;
 b=KarNVpLg3rvpdmpy3FjFrL5BV3wZnAdjEOAmcnWAOIz1Ca4lu++QhLZDrN6q6xkXB+pTgw6/HK2wfHy7VaXKjav+hXdD4m+hsi1UTh3Ade0Zc3N2ok1B4R/K2jtwfn5SrvEfzTgKkclyA5WPg+958X3DgPNHyaTMnygiOeiW+inE23vp1k9IDKB5oEHpW4vVCziEgN55YGIuhV2qcorta5jDtpB64TqIuW3BPJjLQOTkbjpgFvt5OoL2cIklxyNqvwyGM2DgC/S1tKkk5nU/zrJj6ejXgjMyaUbxlG871ZUqPiwiHJ7F1vlUt7/W3EcgkKCeklJostkDFbhIbZlErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BN8PR11MB3764.namprd11.prod.outlook.com (2603:10b6:408:90::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 02:34:13 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 02:34:13 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Yusuf Khan <yusisamerican@gmail.com>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>
Subject: RE: [PATCH -next] pga: dfl: pci: Make sure DMA related error check is
 not done twice
Thread-Topic: [PATCH -next] pga: dfl: pci: Make sure DMA related error check
 is not done twice
Thread-Index: AQHYLRTWzxZDNN1GXEKhzsCEdkt2xA==
Date:   Tue, 1 Mar 2022 02:34:13 +0000
Message-ID: <DM6PR11MB3819F561A8EEB59D9EA1482685029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220222042700.385001-1-yusisamerican@gmail.com>
 <CAJoG2+-97KyWrxym2NXECRtjT9OxVQE_=DcNkUfOsPm_Ax90Aw@mail.gmail.com>
 <20220225155208.GA1377611@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819C9631EAED0AFE7E8D99B85019@DM6PR11MB3819.namprd11.prod.outlook.com>
 <CAJoG2+--e6BqpwBYO0w4d_aUwmCmJVch=mvfq7idW__PRxsv6w@mail.gmail.com>
In-Reply-To: <CAJoG2+--e6BqpwBYO0w4d_aUwmCmJVch=mvfq7idW__PRxsv6w@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 73ed0424-3724-4a00-c193-08d9fb2bf989
x-ms-traffictypediagnostic: BN8PR11MB3764:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3764C4E76F191537D17405BD85029@BN8PR11MB3764.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86l11Svotcg5zYgF8QXnDp2+M8ZjmyqrqQh8UfPGjg2a30JxSBQrrcIQvNXzESB+iEVyQrVaKRkarrhn+z8j1oN2+mZNBZuosZfsOHOmY5Ytoqar+5hwxAtRdYt1jXSdmHYY6B3rxxUjNknIncQWaCagTAjmQ4fvv21T/1kM+mYayI/S+rtlcKb/qEb9GZfI3QAJwW9ZTlch10SvN5NU4va9Saw0ytYrESSP2ev9QOZVTXGKgJ41N70mJTQHwzDlPmIw6/7v8MJ5QsNJf8Y2OW4RpPk7zXZcn3f3hLkrNNaVsHPTGpJhtvr2TKabLbo0SqzY+zCKPyQOuqayzL2S5NZ0LSzojoXk3h+BxRdzlGHimzTqrp1BYqpKcB2zDWe56DM9BS9M83isnv0PVyMfiDhJbgj6HaNVIMvlOT/D0paGPErovIg54myuRkm54WL7S6bZXviALPaS9G3ZI46e51eK41qzyIYW6RFrXZfM7on0qWuG/W1gF0pWpcjKwsIY8rOciV5xLLPtgE2IWB7KcZx9SAVPiNCpX2KQ1U8k01DG5RykksGsTjmDXcPS4PYHcK/GMJ3loj08eI5F8NPGTlspA2UPrkQ+GpQ1yl89xRma4oiYU/+50buQWHTV+x/PVBawPr2tPwSoUtY5f8pjMhUiY22gh8m8zlNBNmfJWiHtak4iM10oHdDB2hTq/RrrjOL3Gec7FA2vxwkhA6Dl+oJCL0P3UOrpLsTbf0vbPFcpcI5j+RlnixzKxWQAXsMM8Y/SOCSQQq/08JOBiLt9CCnki2bpnD9Z/6Ngq3JHzsg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(38100700002)(54906003)(83380400001)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(966005)(55016003)(508600001)(122000001)(26005)(4326008)(52536014)(8936002)(84970400001)(8676002)(316002)(9686003)(71200400001)(86362001)(5660300002)(33656002)(82960400001)(7696005)(6506007)(2906002)(38070700005)(53546011)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDNVUXk0VG52UXkyUjhWN2N0bUNYSmRYeXBYNy91bDhZKzF0THZtOEdSblFz?=
 =?utf-8?B?NWJ0dXJjd0NwYWphUGg2WFhOYmlOSFh1a3ZLYUJHbXljR3Rtc0pIRG5aNjRz?=
 =?utf-8?B?M01QZGlxd2ZxRk1abzBxN1d0Vmp0WDJueUIyWUhINmh2S0l0ZU9TNDhBVDRa?=
 =?utf-8?B?eDdJWHBEY1ByZzE2SGhTR3ByYjE5R0ZMSHRxTFZUYkpablIrNVdrcXhzaGFz?=
 =?utf-8?B?djhheUdDSjZtY2hPNVhpdm90ZzZmUHRwRUo2MjZzVzEvVUVsYmsvSDNJdy9p?=
 =?utf-8?B?V3laMHU2cEhUTmJmakcrRzBoY2FKYXVjdk1lVTJ4eFlQZk1Ua0t4ZGNjSVc1?=
 =?utf-8?B?dHJOOGdzb2htWnlCS3lDWVZzeEo0UDRDY1FWeXNqM3pYRDV3UUNYV2RFZWM2?=
 =?utf-8?B?NjAwY2IyWFNYMys5dk9RTUpYVzlFUml5VHUyL29OSlR6bDFVZ0RneGYyQlY1?=
 =?utf-8?B?Z2srMlZhalNqU3JWS2M2QlpCSzFGZVJ2bHlLRHhlSzJ2L1VGenQwNTZEZU5i?=
 =?utf-8?B?UW1FaTdTcEhod0wxUEpaT1R2bG5RcEFWT2J2cGhENUtIYUNaTW8ybE5QL1Bn?=
 =?utf-8?B?WDZQYjIzd25hUGZ4Wi8zZDZpVWg1Qnp4MitUN0N4SURVMEpyZlVLZTgya1VJ?=
 =?utf-8?B?b1BoL2h0RGo2V3g5ZzRNdUJqTUxSdlN2S2hyT3h6Z0ZoZXdjQ2xNdFkrN1Bv?=
 =?utf-8?B?ME9oZmhmdTBJQm54d0VOSy83Ym5FWkZpSnpwdjZmVnB3VjZZK2dYNDJ4Zlhn?=
 =?utf-8?B?V0FqRmFZSjZFUG4rOHNOWExhdzQwZmcvdDBCbFdTTk42UjhaeWFESkNpUE5E?=
 =?utf-8?B?R0s1bGZsbUJOR1BKVHUzc1JyNUZ4U2kzdTB2bjlZMCtXWFZyY2cyWWp2MWcv?=
 =?utf-8?B?cWsySVZWSDRKUkRENzROTHJHMzN3NzhaUUhOUXd4dERVNHRTajR3Z29jNzY2?=
 =?utf-8?B?b3lLTFVxYTJaNjU0VDJKVkVjZmNrakJIZTBFdnhUTWlsTDZrdWdiR1pnUW5l?=
 =?utf-8?B?aHVPaXBKMmhDYmNEeXRqdWVHZzg5Q3VQOE5FSjMzZ0YvdFpHazcrV1l3dWFp?=
 =?utf-8?B?WDF3dlYrem90dTdFSFo2OXc4Ty9ETElndXQwRFR1cjdzK24zYUpJMkNxTHNn?=
 =?utf-8?B?T0Z4V05wSkJLdFhudjJEOXFPNlNrbkpjTFlRQ0xlWmRoaGRtZ2JWUHpFUmow?=
 =?utf-8?B?YWx5TGZ6Wm0rVzBHeHp5YmZ2OVowQ2xKUGJ6Yjl5eEczanQvemNabTlML3VW?=
 =?utf-8?B?a3JFMlEvS0dDZVZzWlJJbkk2NEl4YXRoL1hScG96RDRxL3NsZ1kyQW1ML29K?=
 =?utf-8?B?ZFN2NC9PQmc5OUhlMEFIcWlkSzdHOGZXdU1EOS9vN0pxT0FlSUJDeDhKZ3pV?=
 =?utf-8?B?RU4vNkxXb3l3a0NFSmdvNXI4RWZWL0JpSHVFMm9LYzZ4TW9RMmJ4RFdvekVY?=
 =?utf-8?B?SGZBeTZpWkk3ZHJpQjNyUDJQclFPVjhlMTEzb09xWGNMTEo3RWdFOXFnb1Q0?=
 =?utf-8?B?cGJIVnpwVjhZVlFaTDFMTnBINEU4WGV2QklXbnpJSHFrUW9WYjJRTGlEYkZH?=
 =?utf-8?B?OC90TVJvdWVJUnBhb1hVOFlPQkUxQTBkME5RK2R1VDFHN3Z1WTBPeVpEd1g1?=
 =?utf-8?B?aWluTTl3bkJyN2tMUGtUUnlQMFUrMzVERjRUeEZiNElXa3dCSmtWQ29UOEVH?=
 =?utf-8?B?SjVHU1hHbEhRVU9kSE5lL0lNY2dhNGVsaTF6dysvRW9tN1NXZ1c4dnViWG9w?=
 =?utf-8?B?aEJTbTdSS0g0M1VkY0pDTis0NGFIcGVrV1ZYWWVwWFFrMFFkM2xKTVdBcGVY?=
 =?utf-8?B?RUg0UGpXMWZ4dTBoSzJyb2NyQTJsUkZRUlpNbWRQQlJ1MW5ERnEvRXNia2pW?=
 =?utf-8?B?YWZ6c1M5NUs4aVVoZk13M0FxdXd5dU5BSzN4cHdEakxNNUk5aFpGK2d0TjYz?=
 =?utf-8?B?Rkc5ZnB2TDIyc2haSnA2ek9WcHpUV1BTLzV3VkppbVZJTzFMVGprTkpGS243?=
 =?utf-8?B?cnZqcVd0NHpmZFZrVUR5UDMvbmkwRTBsQllwaDZPNHhtN3c4QzJpS20xVEtS?=
 =?utf-8?B?S3lUQjdEWnRaWVdsb01rN3Z1VXVMb3NLVGtySzBSblNRUjdVV2xlUjJMd2tr?=
 =?utf-8?B?VUcraGhnYTBGK21CRTUzdXR1dXh1dCtySmsvMm5zVmRZT0FKUkYzMUVzU1Z6?=
 =?utf-8?Q?oo4iTz6b7mQNW/T4LHmK5gI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ed0424-3724-4a00-c193-08d9fb2bf989
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 02:34:13.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux5tLfgoueHOdi+l8cDAqlVMTY3XVgfP+Mr7ZIJPCoEhAyVr4qbO9py7ikCcusMkSm9bE35eB+5NFSEkpff1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3764
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdXN1ZiBLaGFuIDx5dXNpc2Ft
ZXJpY2FuQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMSwgMjAyMiA5OjU5IEFN
DQo+IFRvOiBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPg0KPiBDYzogWHUsIFlpbHVuIDx5aWx1
bi54dUBpbnRlbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
ZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IG1kZkBrZXJuZWwub3JnOyB0cml4QHJlZGhhdC5jb20NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAtbmV4dF0gcGdhOiBkZmw6IHBjaTogTWFrZSBzdXJlIERNQSBy
ZWxhdGVkIGVycm9yIGNoZWNrIGlzDQo+IG5vdCBkb25lIHR3aWNlDQo+IA0KPiBXaWxsIGRvLCBi
dXQgSSBkbyBub3Qga25vdyBleGFjdGx5IHdoYXQgdG8gcmVtb3ZlICBmcm9tIHRoZSBjb21taXQg
bWVzc2FnZSwNCj4gSSB1bmRlcnN0YW5kIHdoYXQgdG8gZG8gZm9yIHRoZSB0aXRsZQ0KDQo+ID4g
PiA+ID4gTk9URTogVGhpcyBwYXRjaCBpcyBvbmx5IGZvciB1c2UgaW4gdGhlIGxpbnV4LW5leHQg
YnJhbmNoIGFzIHRoZQ0KPiA+ID4gPiA+IGNvbW1pdCB0aGF0IGNhdXNlZCB0aGlzIGJ1ZyBoYXBw
ZW5lZCB0aGVyZS4NCg0KUmVtb3ZlIHRoaXMgTk9URQ0KDQpIYW8NCg0KPiANCj4gWXVzdWYNCj4g
DQo+IE9uIE1vbiwgRmViIDI4LCAyMDIyIGF0IDE6NTggQU0gV3UsIEhhbyA8aGFvLnd1QGludGVs
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IE9uIE1vbiwgRmViIDIxLCAyMDIyIGF0IDA4OjM5OjQ4
UE0gLTA4MDAsIFl1c3VmIEtoYW4gd3JvdGU6DQo+ID4gPiA+IE5vdGU6IFRoaXMgYnVnIHdhcyBp
bnRyb2R1Y2VkIGhlcmU6DQo+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtDQo+ID4gPiBuZXh0LmdpdC9wYXRjaC8/aWQ9YWRh
M2NhYWJhZjYxMzUxNTAwNzdjM2Y3MjliYjA2ZThmM2I1YjhmNg0KPiA+ID4gPiBJIHNhdyB0aGlz
IGNvbW1pdCBpbnNpZGUgdGhlIGxpbnV4LW5leHQgYnJhbmNoLCBpdCBpcyBub3QgcHJlc2VudCBp
bg0KPiA+ID4gPiB0aGUgbWFpbmxpbmUgYnJhbmNoLg0KPiA+ID4gPiBUaGUgbGludXgtbmV4dCBi
cmFuY2ggd2FzIGxhc3QgdXBkYXRlZCA1IGRheXMgYWdvLCBzbyBJIGFtIHVuc3VyZQ0KPiA+ID4g
PiBhYm91dCB0aGUgc3RhdGUgb2YgdGhhdCBjb21taXQuDQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1v
biwgRmViIDIxLCAyMDIyIGF0IDg6MjcgUE0gWXVzdWYgS2hhbiA8eXVzaXNhbWVyaWNhbkBnbWFp
bC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEluIHRoZSBjYXNlIHRo
YXQgdGhlIERNQSA2NCBiaXQgYml0IG1hc2sgZXJyb3IgY2hlY2sgZG9lcyBub3QgZmFpbCwNCj4g
PiA+ID4gPiB0aGUgZXJyb3IgY2hlY2sgd2lsbCBiZSBkb25lIHR3aWNlLCB0aGlzIHBhdGNoIGZp
eGVkIHRoYXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBOT1RFOiBUaGlzIHBhdGNoIGlzIG9ubHkg
Zm9yIHVzZSBpbiB0aGUgbGludXgtbmV4dCBicmFuY2ggYXMgdGhlDQo+ID4gPiA+ID4gY29tbWl0
IHRoYXQgY2F1c2VkIHRoaXMgYnVnIGhhcHBlbmVkIHRoZXJlLg0KPiA+DQo+ID4gVGhhbmtzIGZv
ciB0aGUgcGF0Y2guDQo+ID4gcGxlYXNlIHJlbW92ZSB0aGlzIGZyb20gdGhlIGNvbW1pdCBtZXNz
YWdlLCBhbmQgZml4IHRoZSB0aXRsZQ0KPiA+IHMvcGdhL2ZwZ2EvDQo+ID4NCj4gPiBUaGFua3MN
Cj4gPiBIYW8NCj4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVzdWYg
S2hhbiA8eXVzaXNhbWVyaWNhbkBnbWFpbC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
IGRyaXZlcnMvZnBnYS9kZmwtcGNpLmMgfCA5ICsrKysrLS0tLQ0KPiA+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMgYi9kcml2ZXJzL2ZwZ2Ev
ZGZsLXBjaS5jDQo+ID4gPiA+ID4gaW5kZXggNzE3YWM5NzE1OTcwLi42MjIyZjE4YWVkNGIgMTAw
NjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1wY2kuYw0KPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMNCj4gPiA+ID4gPiBAQCAtMzU2LDExICszNTYsMTIg
QEAgaW50IGNjaV9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBjaWRldiwgY29uc3QNCj4gPiA+
IHN0cnVjdCBwY2lfZGV2aWNlX2lkICpwY2lkZXZpZCkNCj4gPiA+ID4gPiAgICAgICAgIHBjaV9z
ZXRfbWFzdGVyKHBjaWRldik7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgICAgICAgIHJldCA9IGRt
YV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBjaWRldi0+ZGV2LA0KPiBETUFfQklUX01BU0soNjQp
KTsNCj4gPiA+ID4gPiAtICAgICAgIGlmIChyZXQpDQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAg
IHJldCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBjaWRldi0+ZGV2LA0KPiA+ID4gRE1B
X0JJVF9NQVNLKDMyKSk7DQo+ID4gPiA+ID4gICAgICAgICBpZiAocmV0KSB7DQo+ID4gPiA+ID4g
LSAgICAgICAgICAgICAgIGRldl9lcnIoJnBjaWRldi0+ZGV2LCAiTm8gc3VpdGFibGUgRE1BIHN1
cHBvcnQgYXZhaWxhYmxlLlxuIik7DQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGdvdG8gZGlz
YWJsZV9lcnJvcl9yZXBvcnRfZXhpdDsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0ID0g
ZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmcGNpZGV2LT5kZXYsDQo+ID4gPiBETUFfQklUX01B
U0soMzIpKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBjaWRldi0+ZGV2LCAiTm8gc3VpdGFi
bGUgRE1BIHN1cHBvcnQNCj4gPiA+IGF2YWlsYWJsZS5cbiIpOw0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gZGlzYWJsZV9lcnJvcl9yZXBvcnRfZXhpdDsNCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+IExvb2tzIGdvb2QgdG8gbWUuDQo+ID4g
Pg0KPiA+ID4gQWNrZWQtYnk6IFh1IFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+DQo+ID4gPg0K
PiA+ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICAgICAgICByZXQgPSBj
Y2lfaW5pdF9kcnZkYXRhKHBjaWRldik7DQo+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiAyLjI1LjEN
Cj4gPiA+ID4gPg0K
