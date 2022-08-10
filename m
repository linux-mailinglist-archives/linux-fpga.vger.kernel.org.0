Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BFB58ED9E
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Aug 2022 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiHJNuw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Aug 2022 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiHJNuf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 10 Aug 2022 09:50:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8745F93
        for <linux-fpga@vger.kernel.org>; Wed, 10 Aug 2022 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660139433; x=1691675433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rmjLqesCGUV3ggwL7Pw/h4ZzJUWg8EQvgbduqsELmUY=;
  b=JKZvixhUvHh6K1XOYaWkET8glVcnDygYEV6Iryk3hE6ew/xfj4KVKD7/
   VXdTf0YAaTsMn0N/G/9whpmzKvgCCjuNRasdrOePcNgqsNEnPtJKY3LjT
   leZBrqBMUE+ZPeM/MMXWOyt3qnZdigcwfEa+7l6M70o+EyALhZ5sYoCvd
   d+soNxeCWGQpHAdrr7DQ/TK21wPdYN5ZJ+F8lauaOGX987bFcFqG3LdcF
   V2Ki2uWFrg51CxRw7KraeKpPITy0uNQWyRhH0n03e3a53re75w+iQ9DCG
   03EHaCopQaS/ixU/E2uTf3iiIBLdJy/q/nZikyJRAZSN1AKaWW3y3b7Dc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291874443"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="291874443"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 06:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="633782428"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2022 06:50:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 06:50:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 06:50:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 10 Aug 2022 06:50:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 10 Aug 2022 06:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmGS+N/G02g1SCpPtH1J+4dME/dlfjMOKxp8RLoJsMMgtPVBrSLe5uqLOdBGPcsGAd7caDMo7eudoF1rMH0uhB7GHZPHKRbTNb13s/HSYwg0Oo9ESlRc6XUeHgyHC3mPn1SLFHSzZxdfhcZld2vTKrDXnet338dzHfovl7wiSWkFfDKWddTSFfnLFsvXiad4wNKV7LVowZgac0aYFsJG4ZyjjewDa3NaP97gevsaiBQ2DwUIa6kKO8b2VPknNgK0ogmNRrrgyR/irXII0B70W9AdPmbBbNaS4FjjPe3IZZ0snRQKZrrYivllCnYwf5MyElPO/MEuysUyD7XPKpPwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+igzc74mSL7EjlKHfUYmS41J5+GgpSgrwHYFOCLIBgc=;
 b=kj3NFJ3hw7TYjgXZ+v/85CQiET2B7KmDu7dOu5s55dTjwc0HQhqKu6h6rY8CywhIhJ9hcHNcJCUg1jJhri5kM/XbuLZ8tNyGjDS8c6GYGMs4M1sm5+X+d6BOLCRCAVQD95eMwD/C5VHXRn0xBddppT+euXXbXCrLeS73hnhy3ML0u49b1se//+d2f+pTOtli5Jfj8pabQXVn7kl2DQjZRzKKdXQLJcDjZHkTqMhWu2ziACJVbjPFr90FgrJKsAzgLBRYCmW7+zpoyH2awc7r4/DTiVRTScMUbPetl3AgdCgjkWenCYBnSZ1QgIW9iU4qMwkRVjeh1ooTvjHuDcrfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BN6PR11MB0066.namprd11.prod.outlook.com (2603:10b6:405:67::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 13:50:06 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::d482:3ee0:a92b:bc39]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::d482:3ee0:a92b:bc39%4]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 13:50:06 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>
Subject: RE: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BMC
 images
Thread-Topic: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BMC
 images
Thread-Index: AQHYqujq7gHIjYALEkmxoc4zW0Gyzq2kxMoAgADlkYCAARqUAIABX5vg
Date:   Wed, 10 Aug 2022 13:50:06 +0000
Message-ID: <BN9PR11MB5483C708B697FB470DC22D99E3659@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220808053317.3627-1-tianfei.zhang@intel.com>
 <20220808053317.3627-2-tianfei.zhang@intel.com>
 <YvDeGNn5+lx6oPSt@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2208081510260.279137@rhweight-WRK1>
 <YvKLtorwPLzApCa4@yilunxu-OptiPlex-7050>
In-Reply-To: <YvKLtorwPLzApCa4@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 75c16528-4438-447d-b727-08da7ad73ba8
x-ms-traffictypediagnostic: BN6PR11MB0066:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUe3OeAUqEzqxORK2coB2kkMjHzz0Hqxyl7BYIgXqh6GPcjrun4I3yTxB+2bkkioLVPtnMb8DSggof+fZrxGqIKdwgaCPVopqU9DaBtFyYky7CS0vKhB7aES4Nk+JkxOeu+5Okk/r8Jd9AEdsa+NHtZSXzddS2Ls4wFg2QVuWsI1gg2uyav532cchpxFdU4e/Dl2HKffqwzKZ9YWTahGDhzxRwFOv0fwgCJMeoe4JR54vTxQJpxHiQxOmhavphRDbO5iCJfSrC+JTfkl5gJn2DAkd24Jt+pbB9/U6X4mU3cXX+036CPpFwmE6DXhgngIDxK4zGC2UItUu6BLT8pnRpaW8xRI07eaVxbTwXcWzpb8pt8N5p3HLNebz1hv5NMFm84rNah1ABOoTPBcjLiSwI/7QqofZXv7QD+BEoIHRxvd/bmLhlIw71/5vRDQGaquZ6btgrQUytzm66WK47Uin1Gfgw2EekIB7sULZle8B8ZFL4HWaD0i0W5aAnGTwd3if8sNnSdcxb94bfXwWr22HAhU2ub637lfq5TMax6YDodezKO/HOm95AHe3YtPBfL3rxH4WcRw8fQ2cEiFlG0KvwTgkCtk435hl5gII5aTQaQsk25vMeX37lj7c1V29t242jMjhCQQP9TwdI7hAhV+1XwCs9v6ANz7LJo70/m2vi1oDTdPWdbCZ69XvfAD96Y2AiEe6em5VfRGTSU4byLNRsZ1x1VQ4C7Wcc9spwSRMcJzl5W4Pe7L3W53FF7WELDVC1ZquwerLlW4KDvSgnBKsz/Jq/oxLaMZdKy08ZtohfWqfqIz825+TBD062Y9xTkeCo9sCDjDx1kAU/HgnlXTAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(136003)(396003)(38070700005)(86362001)(7696005)(6506007)(53546011)(9686003)(316002)(55016003)(4326008)(82960400001)(8676002)(41300700001)(2906002)(30864003)(38100700002)(66556008)(122000001)(966005)(76116006)(64756008)(66946007)(478600001)(71200400001)(66476007)(66446008)(33656002)(186003)(110136005)(54906003)(5660300002)(8936002)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y/0R8tsogn/WKeeSNlChDbTAK/ewqB4NRHzVgypJvlrEQ7qIPmK53N9d6L7a?=
 =?us-ascii?Q?duJJSbrTCUSB9gUE1NgBX3lhxT7hGeTnBHOiV7+G6y0a4Nt2YjiAuU9PC95H?=
 =?us-ascii?Q?U6ui6q90CbuKeIKisK8Z2b61MBwuhfYgBeShHpJEeX2jwwVqh0RHLwYUrqfD?=
 =?us-ascii?Q?WnHxA/85V/FnWHxXiHB1lizs+/zcYqz/i6A8Hl1AsOGe4yl4W+u7ebu5D2kW?=
 =?us-ascii?Q?Tj5i/rZYwieKjkI37KiSi34+r6syMb3PwFcj9XNu2bwyY8fY/Vub39vJZFyp?=
 =?us-ascii?Q?AE0p3ShUipIVqAlASZDJbUtHXnvkH6d9PCOcp77bsP9gOyzGG/eRR/aORVVD?=
 =?us-ascii?Q?vubngi9jD1UvrPnE0YxXfUZJ0tpWhr8xpmHW8MK/i4fh9i67PLMeyCp5ad2E?=
 =?us-ascii?Q?UdDIMQS9wovVBP6b/91yckRYvf2p5+JulcUgzZe4zefsuGWzekibOx41jXfb?=
 =?us-ascii?Q?xQDrDgOuyHQ0UNgNz6aFT9PYBT4ceqrF0lNzlDueAtXhXDs8lwSJM2migrdC?=
 =?us-ascii?Q?2nKQHhJWaWjOlySaCqaHydF66dyQgkulBZvBdemM1B0mYZBt2FWzgULAD535?=
 =?us-ascii?Q?huBG+M/vutWBuy/IDK9xybwaMaSNYjHR3tJdOZDmyXidWfrM/nI2fgL8fooh?=
 =?us-ascii?Q?XzJ/oxXJwXVciu8P68MruQwm1UPQkMcRUZC8S9jZPDeRU6MigKzBDsHozubL?=
 =?us-ascii?Q?RYg9g91zJvNdBnpSOsZxo4FJmeT7pIXT07U5N4elBbiR8iBKFzZLIO4uLgn0?=
 =?us-ascii?Q?UtwqOB1DGGvKXdx82Q5Pre/6pWDIXYdVLOyDkKT8dGYyWl4qmZv6oF8idejk?=
 =?us-ascii?Q?Gqc6qP94uRQg8BjAZo0Y1jBxX65cJ6dfvbgxAcBz6ctS34bdBRUE3G3gUici?=
 =?us-ascii?Q?15CZ5AQCDHleoCjoG90eWqHccNifVsRNe2LtSpkH0Nmr/copFJwYWS8woa8Y?=
 =?us-ascii?Q?vbSJjjbQmLfcw4NVODzAXeSqo/srpxclyACMqUBq9nHvIvFJ2owzw6C3UNnT?=
 =?us-ascii?Q?GchI0G9CxrKaE1DQcj1EHwQCU4Ji5htm0e//a25tsJUSDLuLjLJoBE2E3pyr?=
 =?us-ascii?Q?lFd1U/3I1KSmpksV9SWeZN2RvMGJGEbqjd8uS+ev+0GBCAGmB+mxzvzo5seW?=
 =?us-ascii?Q?o/yB1J9ww8TfWSsvbbrWFIradmiG4EW1PRS7y3aSOIOeD+31CO5bdy4NKN4H?=
 =?us-ascii?Q?NAJwA2ed6YFLKJmk7X2hB612N7Xo8r8olYg7Rt339B64BIO8lwo4DwXbMLYY?=
 =?us-ascii?Q?4ARhhyRS8Td/LELkw3kLJFxeaPjItGjQ4UWnovrusDnMS3qVryMs3k9WILFc?=
 =?us-ascii?Q?ggMc+EuH9T7hsTAFjGjR3TZRp7RR141f5OWbBzUM0FdVkl7a/uRJ8/sG1KTu?=
 =?us-ascii?Q?FwGmfAukgaoPCnCRUKUPR19I5lowC0sdZPZBnkhIchH4f9VH9UdaZCudkIBL?=
 =?us-ascii?Q?0LVxMzbUtm7tMVN5LhcnH5lu1AfimhbJYsK+/Si7btlyiTgRocckXdYoNevN?=
 =?us-ascii?Q?Kfn8oHrTi19VebDq8IUmQBUC4R3tbn9y7m1xDtONY1IVHeWvplLTVBb9tX1d?=
 =?us-ascii?Q?BA5v5UyzMjvNRwdYGgIRKC1j5hrclHb/awp6MVrM3QKR3sQq9Q/YIKXyCtg3?=
 =?us-ascii?Q?E8RYkaGlGRJRaR65ltNieVWaklz00+ALPnOkvQT3xBLM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c16528-4438-447d-b727-08da7ad73ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 13:50:06.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5aB4PiCzWPHR4pqlKVuCwlddUdU7dLgl8Sk1sDEjhC1Ixkuzar18liXIrQO0hGgkK0K2dRxtjSR3P/PhgZamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Sent: Wednesday, August 10, 2022 12:31 AM
> To: matthew.gerlach@linux.intel.com
> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; mdf@kernel.org; linux-
> fpga@vger.kernel.org; lee.jones@linaro.org; Weight, Russell H
> <russell.h.weight@intel.com>; Wu, Hao <hao.wu@intel.com>; trix@redhat.com
> Subject: Re: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BM=
C
> images
>=20
> On 2022-08-08 at 16:39:23 -0700, matthew.gerlach@linux.intel.com wrote:
> >
> >
> > On Mon, 8 Aug 2022, Xu Yilun wrote:
> >
> > > On 2022-08-08 at 01:33:16 -0400, Tianfei Zhang wrote:
> > > > From: Russ Weight <russell.h.weight@intel.com>
> > > >
> > > > Add the available_images and image_load sysfs files. The
> > > > available_images file returns a space separated list of key words
> > > > that may be written into the image_load file. These keywords
> > > > describe an FPGA, BMC, or firmware image in FLASH or EEPROM storage=
 that
> may be loaded.
> > > >
> > > > The image_load sysfs file may be written with a key word to
> > > > trigger a reload of an FPGA, BMC, or firmware image from FLASH or E=
EPROM.
> > > >
> > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > > ---
> > > > v3:
> > > > uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
> > > > v2:
> > > > adds the steps for how to use the "image_load" sysfs file.
> > > > ---
> > > >  .../sysfs-driver-intel-m10-bmc-sec-update     |  34 ++++++
> > > >  drivers/fpga/intel-m10-bmc-sec-update.c       | 105 ++++++++++++++=
++++
> > > >  2 files changed, 139 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > > > b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > > > index 0a41afe0ab4c..3d8f04ca6f1b 100644
> > > > ---
> > > > a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > > > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-upd
> > > > +++ ate
> > > > @@ -59,3 +59,37 @@ Contact:	Russ Weight <russell.h.weight@intel.com=
>
> > > >  Description:	Read only. Returns number of times the secure update
> > > >  		staging area has been flashed.
> > > >  		Format: "%u".
> > > > +
> > > > +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
> update/.../control/available_images
> > > > +Date:		July 2022
> > > > +KernelVersion:  5.20
> > > > +Contact:	Russ Weight <russell.h.weight@intel.com>
> > > > +Description:	Read-only. This file returns a space separated list o=
f
> > > > +		key words that may be written into the image_load file
> > > > +		described below. These keywords decribe an FPGA, BMC,
> > > > +		or firmware image in FLASH or EEPROM storage that may
> > > > +		be loaded.
> > > > +
> > > > +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
> update/.../control/image_load
> > > > +Date:		July 2022
> > > > +KernelVersion:  5.20
> > > > +Contact:	Russ Weight <russell.h.weight@intel.com>
> > > > +Description:	Write-only. A key word may be written to this file to
> > > > +		trigger a reload of an FPGA, BMC, or firmware image from
> > > > +		FLASH or EEPROM. Refer to the available_images file for a
> > > > +		list of supported key words for the underlying device.
> > > > +		Writing an unsupported string to this file will result in
> > > > +		EINVAL being returned.
> > > > +		It should remove all of resources related to the old FPGA/BMC
> > > > +		image before trigger the image reload otherwise the host system
> > > > +		may crash. We recommended that follow the below steps or
> > > > +directly
> > >
> > > I suggest we solve this concern first before other detailed refinemen=
ts.
> > >
> > > My opinion is, don't make the sysfs interface dependent of other
> > > user interfaces, like the following:
> > >
> > > > +		use the OPAE RSU script to perform the reload for FPGA/BMC
> image.
> > > > +		Here is the steps to trigger the reload for FPGA/BMC image:
> > > > +		1. disable the AER of the FPGA card.
> > > > +		2. unbind the PFs/VFs which have bound with VFIO/UIO driver.
> > > > +		3. trigger image reload via "image_load" sysfs file.
> > > > +		4. remove all of PCI devices of the FPGA card via
> > > > +		"/sys/bus/pci/devices/xxxx/remove" sysfs file.
> > > > +		5. wait 10 seconds.
> > > > +		6. re-scan the PCI bus via "/sys/bus/pci/rescan" sysfs file.
> > > > +	        7. enable the AER of the FPGA card.
> > >
> > > It is not a good idea the writing of the sysfs node crashes the
> > > system, if we don't follow the whole steps.
> > >
> > > Thanks,
> > > Yilun
> >
> > Hi Yilun,
> >
> > The use case being supported with this trigger is the ability to
> > reconfigure a FPGA or other programmable componenet on a board without
> > the requiring the HW platform be able to power cycle a PCI slot or
> > power cycling the whole system.  Unfortunately, when a FPGA connected
> > to a PCI bus is reconfigured, it can cause a PCI error.  The actual
> > pci error, if any, and any mitigation steps to handle the error is
> > platform specific and dependent on the FPGA image itself.  Therefore
> > predicting and implementing all necessary error
>=20
> Why the error handling is unpredictable?

This error came from BMC/FPGA while burn the image if we don't remove this =
PCI device.
For example, the other kernel thread accessing the FPGA/BMC while we burn t=
he new FPGA image.

>=20
> > mitigation in the kernel as part of the trigger would be an impossible =
task.
>=20
> Or could we just gate the pcie link? Just like we should disable fpga bri=
dges before
> reprogramming any fpga region.

I think PCI "remove" sysfs file will remove all of subdevices like fpga bri=
dges, and process of  disable AER
and trigger PCI remove will mitigate  the PCI errors.

>=20
> Actually I did find something for link disabing which may be useful.
>=20
> https://patchwork.kernel.org/project/linux-pci/patch/20190529104942.74991=
-1-
> mika.westerberg@linux.intel.com/

It looks like this link_disable patch has not accepted by PCI maintainer.
This link_disable sysfs file just want to protect against another user doin=
g rescan.

>=20
> Thanks,
> Yilun
>=20
> >
> > Matthew
> >
> > >
> > > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > index 72c677c910de..3a082911cf67 100644
> > > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > @@ -14,6 +14,8 @@
> > > >  #include <linux/platform_device.h>  #include <linux/slab.h>
> > > >
> > > > +struct image_load;
> > > > +
> > > >  struct m10bmc_sec {
> > > >  	struct device *dev;
> > > >  	struct intel_m10bmc *m10bmc;
> > > > @@ -21,6 +23,12 @@ struct m10bmc_sec {
> > > >  	char *fw_name;
> > > >  	u32 fw_name_id;
> > > >  	bool cancel_request;
> > > > +	struct image_load *image_load;	/* terminated with { } member */
> > > > +};
> > > > +
> > > > +struct image_load {
> > > > +	const char *name;
> > > > +	int (*load_image)(struct m10bmc_sec *sec);
> > > >  };
> > > >
> > > >  static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> > > > @@ -137,6 +145,54 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR +
> > > > CSK_VEC_OFFSET);
> > > >
> > > >  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vect=
or */
> > > >
> > > > +static ssize_t available_images_show(struct device *dev,
> > > > +				     struct device_attribute *attr, char *buf) {
> > > > +	struct m10bmc_sec *sec =3D dev_get_drvdata(dev);
> > > > +	const struct image_load *hndlr;
> > > > +	ssize_t count =3D 0;
> > > > +
> > > > +	for (hndlr =3D sec->image_load; hndlr->name; hndlr++) {
> > > > +		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
> > > > +				   "%s ", hndlr->name);
> > > > +	}
> > > > +
> > > > +	buf[count - 1] =3D '\n';
> > > > +
> > > > +	return count;
> > > > +}
> > > > +static DEVICE_ATTR_RO(available_images);
> > > > +
> > > > +static ssize_t image_load_store(struct device *dev,
> > > > +				struct device_attribute *attr,
> > > > +				const char *buf, size_t count) {
> > > > +	struct m10bmc_sec *sec =3D dev_get_drvdata(dev);
> > > > +	const struct image_load *hndlr;
> > > > +	int ret =3D -EINVAL;
> > > > +
> > > > +	for (hndlr =3D sec->image_load; hndlr->name; hndlr++) {
> > > > +		if (sysfs_streq(buf, hndlr->name)) {
> > > > +			ret =3D hndlr->load_image(sec);
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return ret ? : count;
> > > > +}
> > > > +static DEVICE_ATTR_WO(image_load);
> > > > +
> > > > +static struct attribute *m10bmc_control_attrs[] =3D {
> > > > +	&dev_attr_available_images.attr,
> > > > +	&dev_attr_image_load.attr,
> > > > +	NULL,
> > > > +};
> > > > +
> > > > +static struct attribute_group m10bmc_control_attr_group =3D {
> > > > +	.name =3D "control",
> > > > +	.attrs =3D m10bmc_control_attrs,
> > > > +};
> > > > +
> > > >  static ssize_t flash_count_show(struct device *dev,
> > > >  				struct device_attribute *attr, char *buf)  { @@ -
> 195,6 +251,7
> > > > @@ static struct attribute_group m10bmc_security_attr_group =3D {
> > > >
> > > >  static const struct attribute_group *m10bmc_sec_attr_groups[] =3D =
{
> > > >  	&m10bmc_security_attr_group,
> > > > +	&m10bmc_control_attr_group,
> > > >  	NULL,
> > > >  };
> > > >
> > > > @@ -208,6 +265,53 @@ static void log_error_regs(struct m10bmc_sec *=
sec,
> u32 doorbell)
> > > >  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);  }
> > > >
> > > > +static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec,
> > > > +				     unsigned int val)
> > > > +{
> > > > +	u32 doorbell;
> > > > +	int ret;
> > > > +
> > > > +	if (val > 1) {
> > > > +		dev_err(sec->dev, "invalid reload val =3D %d\n", val);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	ret =3D m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (doorbell & DRBL_REBOOT_DISABLED)
> > > > +		return -EBUSY;
> > > > +
> > > > +	return regmap_update_bits(sec->m10bmc->regmap,
> > > > +				  M10BMC_SYS_BASE + M10BMC_DOORBELL,
> > > > +				  DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
> > > > +				  FIELD_PREP(DRBL_CONFIG_SEL, val) |
> > > > +				  DRBL_REBOOT_REQ);
> > > > +}
> > > > +
> > > > +static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec) {
> > > > +	return m10bmc_sec_bmc_image_load(sec, 0); }
> > > > +
> > > > +static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec) {
> > > > +	return m10bmc_sec_bmc_image_load(sec, 1); }
> > > > +
> > > > +static struct image_load m10bmc_image_load_hndlrs[] =3D {
> > > > +	{
> > > > +		.name =3D "bmc_factory",
> > > > +		.load_image =3D m10bmc_sec_bmc_image_load_1,
> > > > +	},
> > > > +	{
> > > > +		.name =3D "bmc_user",
> > > > +		.load_image =3D m10bmc_sec_bmc_image_load_0,
> > > > +	},
> > > > +	{}
> > > > +};
> > > > +
> > > >  static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
> > > > {
> > > >  	u32 doorbell;
> > > > @@ -565,6 +669,7 @@ static int m10bmc_sec_probe(struct platform_dev=
ice
> *pdev)
> > > >  	sec->dev =3D &pdev->dev;
> > > >  	sec->m10bmc =3D dev_get_drvdata(pdev->dev.parent);
> > > >  	dev_set_drvdata(&pdev->dev, sec);
> > > > +	sec->image_load =3D m10bmc_image_load_hndlrs;
> > > >
> > > >  	ret =3D xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
> > > >  		       xa_limit_32b, GFP_KERNEL);
> > > > --
> > > > 2.26.2
> > > >
> > >
