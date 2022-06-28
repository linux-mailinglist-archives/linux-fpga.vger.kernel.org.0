Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6462B55D5C3
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243776AbiF1DvV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Jun 2022 23:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243730AbiF1DvU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Jun 2022 23:51:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF527B04;
        Mon, 27 Jun 2022 20:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656388279; x=1687924279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CgSuOJQhakL4hPbNAR1fP04gS/tzEKtupRBCGD6G9Vo=;
  b=kVT5P8d8S9h9fWWXTErKfYi2NlXuvDeV5xmJAVY/W1CarKLcu77FizOx
   f199ot9YpYq0stGreFD4AbwaPEudTNFnvJRmNpY6sE2O9UTYdNzVGUSVE
   Pit+M1ek8somE6lzrOVwZFY8RKH8etiqhITNmPgbElv44EOHZ6QeT5NmX
   w0lIF3ldwOnYwNUYD7+hzdwKjp4cQVQ42+TylOX11Od7zlgAQCwTPV6Ik
   KPvsfv1wiq5q1IwXnqx7Ir/ZeIrLzoIF5IuwUMAnSpb6jtXTUi6NQpFz0
   C73/5hJBqNNm3RE85uS2ZQ7qRL3wCVVb7Ic6vPVZszQhW9CMd1RErfmbc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270372646"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270372646"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="617034201"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 27 Jun 2022 20:51:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 20:51:17 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 20:51:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 20:51:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 20:51:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT1g87YMmzaEfbPyqbos9hXJlRYYxdephr0o8C6QnMhJqj+qxyZdBMQDe1j45Pzp59d0daBouvBWguyVmtvUxa/LnNIpFOYIYyftGDD3XVua/pZLfawraVWKSApDkGTuPTKQBP1YoglfOliQGDrOwIAVL4YJvfXfzzI0anrBLuM3t1yZ9c/aK4eWOwzrcOcs08jNu82seVZ4tuTBFsNKIZTQc95NTEz4Y5IEgPIYVq1UULrP5E5/34P+rJmvUpLARlWRazKufi1sjVu4rPVUY7M0+vX6D+2Y0Z4CbMCVdlXWa4ZmFFuAhSvL/p4VcXMuoX+85ILJTZVVsYOYEilRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXG+p+vQaOXrAb7F0woIelrfpkrl/PE2axMn374c/HE=;
 b=Xm2Lq2w1kAgBSCkTmkMViG7tm9gGusyd7cEW0drO6NYhyWiX6N9jkmimsvCX0WTCCxOOXJhkK/MEHotcJbxAqSU9hrLb8OxTCryLNCwnXxMsIbNoibhANRKNk62aPtRoygDPCquQwY5wrUAI7GivJ65ZnfZ9Kmp9hx0QnseGhm1j5d0iLm+O01DOGLotQZaJ9o7U7Y+j0O6q1aymSfilkWvjomDTKhWcL/VWrxQ3T1VPzU0JGvfYl+xFC72lU7kFdZMDkItxnBP1veuzCe1J1/gbxcaODXucp61+mTg7RTXE5mueuqGa9m+k+tQle/i1VZe8nTpbdDHexvEKdZk4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 03:51:08 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10%6]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 03:51:07 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Wu, Hao" <hao.wu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
Thread-Topic: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
Thread-Index: AQHYh6x7/34rm0XpBU+UVV57Dvt+/a1gJmaAgAMkxaCAACv/AIAAvHLQ
Date:   Tue, 28 Jun 2022 03:51:07 +0000
Message-ID: <BN9PR11MB5483959A31FC671F9CA469B3E3B89@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
 <20220624092229.45854-3-tianfei.zhang@intel.com>
 <b3ab1b27-648b-9a0a-b613-980c37db0ae9@redhat.com>
 <BN9PR11MB54839B9631B5DC1EE13404DEE3B99@BN9PR11MB5483.namprd11.prod.outlook.com>
 <20220627163048.GA2311255@yilunxu-OptiPlex-7050>
In-Reply-To: <20220627163048.GA2311255@yilunxu-OptiPlex-7050>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12a96eee-7e2b-4366-6667-08da58b96ee1
x-ms-traffictypediagnostic: PH0PR11MB4789:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiJlhXkm8VrjDyHmIOhfyAkE06NKPCPR/ahowVu65lQ7VZhHh4nO8LYBoaVRqzeTZGlFhkU/j3OidoaFJ7KzvYMBriKp90Q8d5Odrk2R9Ku/GPP9XJjeeX8GIAENiSl8sVa+r8rLB2517iLTRwt0uTFe0YzErEVC3DXPVQHvyR4A2mhlYr5fkNnHpef0Ce1zst0eNobtOxoxiHLKDVVHyyM5UsvaVGstWpqBpp0AUZpMOopfgWw7lVw0s584RPLaYIqQSj/WESg5+BA3dGdJqXsAZ7O+sDb+qC3bkJmtusPZa1oiM3bY2e8yh6WrW71v27gbr5MMQNl54laQ/rCDGHM+8makEfwatrIAQHseJMuy4lFQHDidmL5GFSGw06W1rVOpILkEqtr0sr1yo47senTYDWg/ghNVIzURRwWKRfEL7LftvcaH6KgGIvq2yVFEZZuPtoBh6muHCN51uANDj7K/YW7d+CdZMcCg7TIJ2XK/v0MBMDKz0fr1XLTpnPC/WRUVxY4KUQrgiLV8Q6r7eab4hxZSxU3nMKAjKxSm6IvH5bspaoNxVKtecNdjwjo2qWVS3VWvEZy6uekv66x//L06d9xJnokZ6iL3KkZZDUuY4UBUeQxGX+HMUljGa63OPtMLJ54eeO9dh0bEgaNUtkHO+zxIOMhho6gDtWLTS1jPdKJboPsepeaXLR31VBBnFZzbPs5P4kq6IszddD8KVrqTSdUz2jGzs5jDD55EonoyqVt73sq3cqBILu0ojFmYMwgp90qzNWgBxSBFcTV9AlrDTlTn7FqceyEZY9pmK2yrA11MqvJ01m7SFR9qxuu4utTJV7BTWL6dPEHeFTdngQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(39860400002)(366004)(396003)(30864003)(33656002)(478600001)(966005)(66946007)(5660300002)(316002)(4326008)(9686003)(53546011)(52536014)(6506007)(8936002)(8676002)(41300700001)(86362001)(2906002)(66446008)(66556008)(82960400001)(6636002)(6862004)(7696005)(54906003)(83380400001)(64756008)(55016003)(76116006)(122000001)(38070700005)(186003)(38100700002)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CHNcQEenjMbvMNHGYdbWBJV3pyXnAl0i1HS/rBdV6wCB7eXN9EV622Njc3HZ?=
 =?us-ascii?Q?vZ4eEGDSlz10xf/pXXSoLxqVnnlAFQIZiu6GMWyjBqalyLZG8e/zTBs8KUQ/?=
 =?us-ascii?Q?vDowW1bVk7wj9rmoJ3VPnwKRuOO4XcSXi9eEdKqhGdbhvpidBtxwlmwhj2xj?=
 =?us-ascii?Q?oaXEhyjvXH2FgjjNLPuajWiqf+zG8Q3+zapFHyKnrFRT3zDZzwmCewBkDYlS?=
 =?us-ascii?Q?8iqm2WcZcLpOiHzfBKdsuVuXubXrRQMBIdBPt2tULOlqTsoqBxOxEZbwbH+x?=
 =?us-ascii?Q?t8xWOvU78Wr6ZBti8I9Uv3takbPepTGqfWslF8rPRTJ2Rx/GxR3/naA2tdI2?=
 =?us-ascii?Q?fg04yFTTOz9FzK/SQhNg4BpzxhPm+8FY0Xl5xsNzosatwuLRPsIQdvZS46OJ?=
 =?us-ascii?Q?8OX3wAJCHjwzvfpWwnhOmjay0HesvwuXH57K1dEyhCqLC+SFFPDBqUcKJpaw?=
 =?us-ascii?Q?0DCx2NWLELUMkTo+T8Y8eDsS8uy3u98nDdaBGzzlpit+a0wr0AuPaUzdh5Gg?=
 =?us-ascii?Q?RBBJkKnJmtUUHkapGhpn8LwkI42Sguji9kbG4HVQXrI3hV4dcnJQn9frCjMt?=
 =?us-ascii?Q?PsOLyiilGW4d7yDIf+av7yUqG+5pfNdxaBTIGPCGa+N+e86bu6W+rsyBpdg+?=
 =?us-ascii?Q?DWVab6oLtvMj5+JlEXZJbBOyb2BhsSjhLP6uBljh3JfBDAzcYRWr9xYdcfQH?=
 =?us-ascii?Q?U3qlnz96evzDxSWVrJxExw+9DNJbyVdwjFxPUUAxdL7J4PeWNbG7W3HnAoi3?=
 =?us-ascii?Q?qo/vRr7vt1TbMBVG9d6GwwqYs65ivLA6Sjw5l1D6gCtcenFUL+7Bt5XC46Ul?=
 =?us-ascii?Q?wmQg1vuO7BKGvICtCAdXqqY6GlGJdD9FwNpXS4fiTnDmRVON0ficDik/ZZn2?=
 =?us-ascii?Q?lcqpTvHyCZpEX1chzoa78K4YrBXGATfVKVeYFg/OF/Am5ZCYCTOwpkPmnHZ7?=
 =?us-ascii?Q?fZQN9HJt1pHrAsBUI064NUCMgUZQp12M4v0FR9zYw01ioyowqcxh/FZ/eclH?=
 =?us-ascii?Q?M3WRHqE8fOcJiXbBUPBcI3xRPpugvJT2Ziw5JsKJRKvTseqE6XZS0xIAUC35?=
 =?us-ascii?Q?Z+ePYXASOsdZwnkMitSxynMsL33WWJjHDaqI2YjjTILxXOYi3Pqa6B1hZ2l1?=
 =?us-ascii?Q?4U3gR1oYp1A6aOTYxPmvZsKVP1z4NTukvKBE/dIJri7TP1xa+ZtIaWuEkGNY?=
 =?us-ascii?Q?QapfjZcN/rWkSKj9FKTUx/IWc+ZptcYk5nq9knMUzGdr73kbDTsDuuTcSrIt?=
 =?us-ascii?Q?gdTWB9RUoGpW9EiYv++/Ye6EQe1I+uZ57o73z6g1Zwn1yXEdTD588AGtfm1W?=
 =?us-ascii?Q?k+71fxyBLKKbop6VQWawRsPXStucIYfdFyUeRT8j9Bv+kdVOXxkZ0jTUDFUM?=
 =?us-ascii?Q?qJDJIvygP6iyRaOAGEy0RAkCz88paShXXrWNH4SjM2mllvbTnlNtIjZ1xVq0?=
 =?us-ascii?Q?yVeMmhr5daDphQqWGyftpW2LAkuzU/RKCWsS+7Sk3ef6PqFIplrzz0jUcSr9?=
 =?us-ascii?Q?xxR21WPHjFdm6bMal1NdqeCwPsmAYUH1qR505uZ4wUU9aoW8Jyxc/IvtTbw3?=
 =?us-ascii?Q?TYVlXESwzhDvfYOhYjlmFPnUxvA6R2qfmNBYPSnCUkbEvmyJVKT4T3vUAbBf?=
 =?us-ascii?Q?YdNTgLTbreuIq9CNcScTrqJdS5GD+MocpP2zx9JfCg6e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a96eee-7e2b-4366-6667-08da58b96ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 03:51:07.8181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veYCrJ5sU/fCzJO+elHtXQ5wtcgIo4GppdK7J4Svst3h5L/tWalY4geLCs7P5VZZRtDjiUtcTq5+TScFefpb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Tuesday, June 28, 2022 12:31 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Tom Rix <trix@redhat.com>; lee.jones@linaro.org; Wu, Hao
> <hao.wu@intel.com>; linux-kernel@vger.kernel.org; linux-
> fpga@vger.kernel.org; Weight, Russell H <russell.h.weight@intel.com>;
> matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
>=20
> On Mon, Jun 27, 2022 at 10:03:35PM +0800, Zhang, Tianfei wrote:
> >
> >
> > > -----Original Message-----
> > > From: Tom Rix <trix@redhat.com>
> > > Sent: Saturday, June 25, 2022 9:53 PM
> > > To: Zhang, Tianfei <tianfei.zhang@intel.com>; Xu, Yilun
> > > <yilun.xu@intel.com>; lee.jones@linaro.org
> > > Cc: Wu, Hao <hao.wu@intel.com>; linux-kernel@vger.kernel.org; linux-
> > > fpga@vger.kernel.org; Weight, Russell H
> > > <russell.h.weight@intel.com>; matthew.gerlach@linux.intel.com
> > > Subject: Re: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
> > >
> > >
> > > On 6/24/22 2:22 AM, Tianfei Zhang wrote:
> > > > Adding a driver for the PMCI-base interface of Intel MAX10 BMC
> > > > controller.
> > > >
> > > > PMCI(Platform Management Control Interface) is a software-visible
> > > > interface, connected to card BMC which provided the basic
> > > > functionality of read/write BMC register. On the other hand, this
> > > > driver leverages the regmap APIs to support Intel specific
> > > > Indirect Register Interface for register read/write on PMCI.
> > > >
> > > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > ---
> > > > v3:
> > > >     - create a new driver for intel-m10-bmc-pmci driver
> > > >     - remove the regmap_access_table
> > > >     - create a new file for sysfs-driver-intel-m10-bmc-pmci ABI
> > > > v2:
> > > >     - fix compile warning reported by lkp
> > > >     - use regmap API for Indirect Register Interface.
> > > > ---
> > > >   .../testing/sysfs-driver-intel-m10-bmc-pmci   |  36 +++
> > > >   drivers/mfd/Kconfig                           |  10 +
> > > >   drivers/mfd/Makefile                          |   1 +
> > > >   drivers/mfd/intel-m10-bmc-pmci.c              | 277 +++++++++++++=
+++++
> > > >   include/linux/mfd/intel-m10-bmc.h             |   8 +
> > > >   5 files changed, 332 insertions(+)
> > > >   create mode 100644
> > > > Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-
> > > pmci
> > > >   create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
> > > >
> > > > diff --git
> > > > a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> > > > b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> > > > new file mode 100644
> > > > index 000000000000..03371b8022ae
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> > > > @@ -0,0 +1,36 @@
> > > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > > bmc/dfl_dev.X/bmc_version
> > > > +Date:              June 2022
> > > > +KernelVersion:     5.19
> > > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > > +Description:       Read only. Returns the hardware build version o=
f Intel
> > > > +           MAX10 BMC chip.
> > > > +           Format: "0x%x".
> > > > +
> > > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > > bmc/dfl_dev.X/bmcfw_version
> > > > +Date:              June 2022
> > > > +KernelVersion:     5.19
> > > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > > +Description:       Read only. Returns the firmware version of Inte=
l MAX10
> > > > +           BMC chip.
> > > > +           Format: "0x%x".
> > > > +
> > > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > > bmc/dfl_dev.X/mac_address
> > > > +Date:              June 2022
> > > > +KernelVersion:  5.19
> > > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > > +Description:       Read only. Returns the first MAC address in a b=
lock
> > > > +           of sequential MAC addresses assigned to the board
> > > > +           that is managed by the Intel MAX10 BMC. It is stored in
> > > > +           FLASH storage and is mirrored in the MAX10 BMC register
> > > > +           space.
> > > > +           Format: "%02x:%02x:%02x:%02x:%02x:%02x".
> > > > +
> > > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > > bmc/dfl_dev.X/mac_count
> > > > +Date:              June 2022
> > > > +KernelVersion:  5.19
> > > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > > +Description:       Read only. Returns the number of sequential MAC
> > > > +           addresses assigned to the board managed by the Intel
> > > > +           MAX10 BMC. This value is stored in FLASH and is mirrore=
d
> > > > +           in the MAX10 BMC register space.
> > > > +           Format: "%u".
> > >
> > > This file looks like a duplicate at sys-driver-intel-m10-bmc.
> > >
> > > So the show commands below are duplicates.
> >
> > Yes, I agree that the file " sysfs-driver-intel-m10-bmc" and " sysfs-dr=
iver-intel-
> m10-bmc-pmci" are duplicates, I will combine those into one.
> > >
> > > Refactoring is necessary.
> > >
> > > My recommendation is the existing intel-m10-bmc.c hold the common par=
ts.
> > >
> > > intel-m10-bmc.c is spi, so the spi specific bits be split to new
> > > intel-m10-bmc-spi.c
> >
> > In my V2 patch, I split the intel-m10-bmc.c into intel-m10-bmc-core.c a=
nd
> intel-m10-bmc-pmci.c, intel-m10-bmc-core.c hold the command parts.
> > But Yilun suggested that it is only 40~50 line codes are duplicates,
> > it is no necessary to hold the common parts. In V3 patch, I directly wr=
ite a
> separate driver for intel-m10-bmc-pmci driver.
>=20
> Hi tianfei:
>=20
> I see the driver still includes intel-m10-bmc.h, and uses struct intel_m1=
0bmc. So I
> don't think this is a separate driver.
>=20
> I think to be a separate driver, it should remove the dependency to
> intel_m10bmc. The subdevice drivers should also remove the dependency to
> intel_m10bmc. So maybe you need to estimate whether to make the separate
> driver or still reuse the intel-m10-bmc.

There are lots of logic and functionalities are very similar with the SPI b=
us type BMC
and PMCI bus type BMC. In my opinion, I like to split into: intel-m10-bmc-c=
ore.c,=20
intel-m10-bmc-spi.c and intel-m10-bmc-pmci.c, as Tom's suggestion that it w=
ill reduce
some duplicate code.

In V2 patch, I have done by this idea,
https://lore.kernel.org/linux-fpga/20220617020405.128352-1-tianfei.zhang@in=
tel.com

if you are all agree this idea, I will send the v4 patchset base on it.

>=20
> Thanks,
> Yilun
>=20
> >
> > >
> > > Tom
> > >
> > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> > > > 3b59456f5545..ee196c41a9db 100644
> > > > --- a/drivers/mfd/Kconfig
> > > > +++ b/drivers/mfd/Kconfig
> > > > @@ -2171,6 +2171,16 @@ config MFD_INTEL_M10_BMC
> > > >       additional drivers must be enabled in order to use the functi=
onality
> > > >       of the device.
> > > >
> > > > +config MFD_INTEL_M10_BMC_PMCI
> > > > +   tristate "Intel MAX 10 Board Management Controller with PMCI"
> > > > +   depends on FPGA_DFL
> > > > +   help
> > > > +     Support for the Intel MAX 10 board management controller via =
PMCI.
> > > > +
> > > > +     This driver provides common support for accessing the device,
> > > > +     additional drivers must be enabled in order to use the functi=
onality
> > > > +     of the device.
> > > > +
> > > >   config MFD_RSMU_I2C
> > > >     tristate "Renesas Synchronization Management Unit with I2C"
> > > >     depends on I2C && OF
> > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
> > > > 858cacf659d6..f737bd7b7d98 100644
> > > > --- a/drivers/mfd/Makefile
> > > > +++ b/drivers/mfd/Makefile
> > > > @@ -267,6 +267,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)   +=3D qcom-
> > > pm8008.o
> > > >   obj-$(CONFIG_SGI_MFD_IOC3)        +=3D ioc3.o
> > > >   obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)  +=3D simple-mfd-i2c.o
> > > >   obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> > > > +obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   +=3D intel-m10-bmc-pmci.o
> > > >
> > > >   obj-$(CONFIG_MFD_ATC260X) +=3D atc260x-core.o
> > > >   obj-$(CONFIG_MFD_ATC260X_I2C)     +=3D atc260x-i2c.o
> > > > diff --git a/drivers/mfd/intel-m10-bmc-pmci.c
> > > > b/drivers/mfd/intel-m10-bmc-pmci.c
> > > > new file mode 100644
> > > > index 000000000000..93eca4483ac7
> > > > --- /dev/null
> > > > +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> > > > @@ -0,0 +1,277 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * PMCI-based interface to MAX10 BMC
> > > > + *
> > > > + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> > > > + *
> > > > + */
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/dfl.h>
> > > > +#include <linux/mfd/intel-m10-bmc.h> #include <linux/module.h>
> > > > +#include <linux/regmap.h> #include <linux/mfd/core.h>
> > > > +
> > > > +#define M10BMC_PMCI_INDIRECT_BASE 0x400
> > > > +#define INDIRECT_INT_US        1
> > > > +#define INDIRECT_TIMEOUT_US    10000
> > > > +
> > > > +#define INDIRECT_CMD_OFF   0x0
> > > > +#define INDIRECT_CMD_RD    BIT(0)
> > > > +#define INDIRECT_CMD_WR    BIT(1)
> > > > +#define INDIRECT_CMD_ACK   BIT(2)
> > > > +
> > > > +#define INDIRECT_ADDR_OFF  0x4
> > > > +#define INDIRECT_RD_OFF    0x8
> > > > +#define INDIRECT_WR_OFF    0xc
> > > > +
> > > > +struct indirect_ctx {
> > > > +   void __iomem *base;
> > > > +   struct device *dev;
> > > > +   unsigned long sleep_us;
> > > > +   unsigned long timeout_us;
> > > > +};
> > > > +
> > > > +struct pmci_device {
> > > > +   void __iomem *base;
> > > > +   struct device *dev;
> > > > +   struct intel_m10bmc m10bmc;
> > > > +   struct indirect_ctx ctx;
> > > > +};
> > > > +
> > > > +static int pmci_indirect_bus_clr_cmd(struct indirect_ctx *ctx) {
> > > > +   unsigned int cmd;
> > > > +   int ret;
> > > > +
> > > > +   writel(0, ctx->base + INDIRECT_CMD_OFF);
> > > > +   ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > > +                            (!cmd), ctx->sleep_us, ctx->timeout_us=
);
> > > > +   if (ret)
> > > > +           dev_err(ctx->dev, "%s timed out on clearing cmd
> > > > + 0x%xn",
> > > __func__,
> > > > +cmd);
> > > > +
> > > > +   return ret;
> > > > +}
> > > > +
> > > > +static int pmci_indirect_bus_reg_read(void *context, unsigned int =
reg,
> > > > +                                 unsigned int *val) {
> > > > +   struct indirect_ctx *ctx =3D context;
> > > > +   unsigned int cmd;
> > > > +   int ret;
> > > > +
> > > > +   cmd =3D readl(ctx->base + INDIRECT_CMD_OFF);
> > > > +   if (cmd)
> > > > +           dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__,
> > > cmd);
> > > > +
> > > > +   writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> > > > +   writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
> > > > +   ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > > +                            (cmd & INDIRECT_CMD_ACK), ctx->sleep_u=
s,
> > > > +                            ctx->timeout_us);
> > > > +   if (ret) {
> > > > +           dev_err(ctx->dev, "%s timed out on reg 0x%x cmd
> > > > + 0x%x\n",
> > > __func__, reg, cmd);
> > > > +           goto out;
> > > > +   }
> > > > +
> > > > +   *val =3D readl(ctx->base + INDIRECT_RD_OFF);
> > > > +
> > > > +   if (pmci_indirect_bus_clr_cmd(ctx))
> > > > +           ret =3D -ETIMEDOUT;
> > > > +
> > > > +out:
> > > > +   return ret;
> > > > +}
> > > > +
> > > > +static int pmci_indirect_bus_reg_write(void *context, unsigned int=
 reg,
> > > > +                                  unsigned int val) {
> > > > +   struct indirect_ctx *ctx =3D context;
> > > > +   unsigned int cmd;
> > > > +   int ret;
> > > > +
> > > > +   cmd =3D readl(ctx->base + INDIRECT_CMD_OFF);
> > > > +   if (cmd)
> > > > +           dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__,
> > > cmd);
> > > > +
> > > > +   writel(val, ctx->base + INDIRECT_WR_OFF);
> > > > +   writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> > > > +   writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
> > > > +   ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > > +                            (cmd & INDIRECT_CMD_ACK), ctx->sleep_u=
s,
> > > > +                            ctx->timeout_us);
> > > > +   if (ret) {
> > > > +           dev_err(ctx->dev, "%s timed out on reg 0x%x cmd
> > > > + 0x%x\n",
> > > __func__, reg, cmd);
> > > > +           goto out;
> > > > +   }
> > > > +
> > > > +   if (pmci_indirect_bus_clr_cmd(ctx))
> > > > +           ret =3D -ETIMEDOUT;
> > > > +
> > > > +out:
> > > > +   return ret;
> > > > +}
> > > > +
> > > > +static const struct regmap_bus pmci_indirect_bus =3D {
> > > > +   .reg_write =3D pmci_indirect_bus_reg_write,
> > > > +   .reg_read =3D  pmci_indirect_bus_reg_read, };
> > > > +
> > > > +static struct mfd_cell m10bmc_n6000_bmc_subdevs[] =3D {
> > > > +   { .name =3D "n6000bmc-hwmon" },
> > > > +   { .name =3D "n6000bmc-sec-update" } };
> > > > +
> > > > +static struct regmap_config m10bmc_pmci_regmap_config =3D {
> > > > +   .reg_bits =3D 32,
> > > > +   .reg_stride =3D 4,
> > > > +   .val_bits =3D 32,
> > > > +   .max_register =3D M10BMC_PMCI_SYS_END, };
> > > > +
> > > > +static ssize_t bmc_version_show(struct device *dev,
> > > > +                           struct device_attribute *attr, char *bu=
f) {
> > > > +   struct intel_m10bmc *ddata =3D dev_get_drvdata(dev);
> > > > +   unsigned int val;
> > > > +   int ret;
> > > > +
> > > > +   ret =3D m10bmc_sys_read(ddata, M10BMC_PMCI_BUILD_VER, &val);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   return sprintf(buf, "0x%x\n", val); } static
> > > > +DEVICE_ATTR_RO(bmc_version);
> > > > +
> > > > +static ssize_t bmcfw_version_show(struct device *dev,
> > > > +                             struct device_attribute *attr, char *=
buf) {
> > > > +   struct intel_m10bmc *ddata =3D dev_get_drvdata(dev);
> > > > +   unsigned int val;
> > > > +   int ret;
> > > > +
> > > > +   ret =3D m10bmc_sys_read(ddata, NIOS2_PMCI_FW_VERSION, &val);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   return sprintf(buf, "0x%x\n", val); } static
> > > > +DEVICE_ATTR_RO(bmcfw_version);
> > > > +
> > > > +static ssize_t mac_address_show(struct device *dev,
> > > > +                           struct device_attribute *attr, char *bu=
f) {
> > > > +   struct intel_m10bmc *max10 =3D dev_get_drvdata(dev);
> > > > +   unsigned int macaddr_low, macaddr_high;
> > > > +   int ret;
> > > > +
> > > > +   ret =3D m10bmc_sys_read(max10, M10BMC_PMCI_MAC_LOW,
> > > &macaddr_low);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   ret =3D m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH,
> > > &macaddr_high);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
> > > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr_low),
> > > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr_low),
> > > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr_low),
> > > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr_low),
> > > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE5,
> > > macaddr_high),
> > > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE6,
> > > macaddr_high)); } static
> > > > +DEVICE_ATTR_RO(mac_address);
> > > > +
> > > > +static ssize_t mac_count_show(struct device *dev,
> > > > +                         struct device_attribute *attr, char *buf)=
 {
> > > > +   struct intel_m10bmc *max10 =3D dev_get_drvdata(dev);
> > > > +   unsigned int macaddr_high;
> > > > +   int ret;
> > > > +
> > > > +   ret =3D m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH,
> > > &macaddr_high);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   return sysfs_emit(buf, "%u\n",
> > > > +                     (u8)FIELD_GET(M10BMC_MAC_COUNT,
> > > macaddr_high)); } static
> > > > +DEVICE_ATTR_RO(mac_count);
> > > > +
> > > > +static struct attribute *m10bmc_attrs[] =3D {
> > > > +   &dev_attr_bmc_version.attr,
> > > > +   &dev_attr_bmcfw_version.attr,
> > > > +   &dev_attr_mac_address.attr,
> > > > +   &dev_attr_mac_count.attr,
> > > > +   NULL,
> > > > +};
> > > > +ATTRIBUTE_GROUPS(m10bmc);
> > > > +
> > > > +static int pmci_probe(struct dfl_device *ddev) {
> > > > +   struct device *dev =3D &ddev->dev;
> > > > +   struct mfd_cell *cells;
> > > > +   struct pmci_device *pmci;
> > > > +   int ret, n_cell;
> > > > +
> > > > +   pmci =3D devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> > > > +   if (!pmci)
> > > > +           return -ENOMEM;
> > > > +
> > > > +   pmci->m10bmc.dev =3D dev;
> > > > +   pmci->dev =3D dev;
> > > > +
> > > > +   pmci->base =3D devm_ioremap_resource(dev, &ddev->mmio_res);
> > > > +   if (IS_ERR(pmci->base))
> > > > +           return PTR_ERR(pmci->base);
> > > > +
> > > > +   dev_set_drvdata(dev, &pmci->m10bmc);
> > > > +
> > > > +   pmci->ctx.base =3D pmci->base + M10BMC_PMCI_INDIRECT_BASE;
> > > > +   pmci->ctx.sleep_us =3D INDIRECT_INT_US;
> > > > +   pmci->ctx.timeout_us =3D INDIRECT_TIMEOUT_US;
> > > > +   pmci->ctx.dev =3D dev;
> > > > +   pmci->m10bmc.regmap =3D
> > > > +           devm_regmap_init(dev,
> > > > +                            &pmci_indirect_bus,
> > > > +                            &pmci->ctx,
> > > > +                            &m10bmc_pmci_regmap_config);
> > > > +   if (IS_ERR(pmci->m10bmc.regmap))
> > > > +           return PTR_ERR(pmci->m10bmc.regmap);
> > > > +
> > > > +   cells =3D m10bmc_n6000_bmc_subdevs;
> > > > +   n_cell =3D ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
> > > > +
> > > > +   ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > > +                              cells, n_cell, NULL, 0, NULL);
> > > > +   if (ret)
> > > > +           dev_err(dev, "Failed to register sub-devices: %d\n",
> > > > +                   ret);
> > > > +
> > > > +   return ret;
> > > > +}
> > > > +
> > > > +#define FME_FEATURE_ID_PMCI_BMC    0x12
> > > > +
> > > > +static const struct dfl_device_id pmci_ids[] =3D {
> > > > +   { FME_ID, FME_FEATURE_ID_PMCI_BMC },
> > > > +   { }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(dfl, pmci_ids);
> > > > +
> > > > +static struct dfl_driver pmci_driver =3D {
> > > > +   .drv    =3D {
> > > > +           .name       =3D "dfl-pmci-bmc",
> > > > +           .dev_groups =3D m10bmc_groups,
> > > > +   },
> > > > +   .id_table =3D pmci_ids,
> > > > +   .probe    =3D pmci_probe,
> > > > +};
> > > > +
> > > > +module_dfl_driver(pmci_driver);
> > > > +
> > > > +MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
> > > > +MODULE_AUTHOR("Intel Corporation"); MODULE_LICENSE("GPL");
> > > > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > > > b/include/linux/mfd/intel-m10-bmc.h
> > > > index f0044b14136e..7b58af207b72 100644
> > > > --- a/include/linux/mfd/intel-m10-bmc.h
> > > > +++ b/include/linux/mfd/intel-m10-bmc.h
> > > > @@ -118,6 +118,14 @@
> > > >   /* Address of 4KB inverted bit vector containing staging area FLA=
SH count
> */
> > > >   #define STAGING_FLASH_COUNT       0x17ffb000
> > > >
> > > > +#define M10BMC_PMCI_SYS_BASE 0x0
> > > > +#define M10BMC_PMCI_SYS_END  0xfff
> > > > +
> > > > +#define M10BMC_PMCI_BUILD_VER   0x0
> > > > +#define NIOS2_PMCI_FW_VERSION   0x4
> > > > +#define M10BMC_PMCI_MAC_LOW     0x20
> > > > +#define M10BMC_PMCI_MAC_HIGH    0x24
> > > > +
> > > >   /**
> > > >    * struct intel_m10bmc - Intel MAX 10 BMC parent driver data stru=
cture
> > > >    * @dev: this device
> >
