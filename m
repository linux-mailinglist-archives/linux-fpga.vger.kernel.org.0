Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D007758D432
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Aug 2022 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiHIHFN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Aug 2022 03:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiHIHFK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Aug 2022 03:05:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E6020BEE
        for <linux-fpga@vger.kernel.org>; Tue,  9 Aug 2022 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660028701; x=1691564701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bKWnEJZOMzg9PPoCbpt4gFwjhPGAy/T5s1ZVqooiFlE=;
  b=KwqvTqptATPQzQdH3aYzYEm9Wqty9XSuk/9HBsONz+S+kbqESIMElvUg
   Xt4bgU1D/OI7pAVyitPICdBpNEENJD0ujPp0T/9tr3PaeBGF1lulwURKI
   YryaP1FibBNZ4EfLJZyzpCOBE2gbKTpdAoaKtDw7ERbj3T7+l8qlmdOX6
   71G0SOJPQ0xYhxHYn7p0NIQuUEYmH4oIFH7FPgFyWpBZKGH51DOP8rhpR
   GjaNkLpaehVBhNhTbPtuWwBq4+lli+hF4piX8rnESs8RPa/fF+fVWSKCG
   fvX3QiJ41sQWdMcPoNyMC7YQSK+27fCF9Xi6pNNy6WYkcPvza2ihaWrPq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="292010415"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="292010415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 00:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="633221146"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2022 00:05:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 00:05:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 00:04:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 00:04:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 00:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3kLQDCiQ9W7qfJo+UJMgW8gJFsVssPxa++gU7SN+Fcpl2cCfSFXmuLA/xn+xwV6jD1BQBHm9khVThfdGCJzIbGtblxiEYF+y1FvRHuQuMRp41VuPx1Or0AsmMRoGNxEPl4o2h8KBdmdfLe51gAp2qfv9z1kEjkPFevNaUQXJxzY+o+BnnF51D7nXybcEO7cSVIq/3US06CQLp/aj4LQcedZb6r+NG8WEAq5KCw8TKkEx2s5zUGaWYCu6oUd313reXYBmwsG/ymk3ToK2PIE2NS8En5aL9eWTqN1vEtxAAPtpBZtSmlQZIdeF6huP2QRROV8Q19rqltf1HR2f2BciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s1ntynYSqKBKJqU14y3jOXCZYOIK7Ypx2AoQx+hutI=;
 b=HT39sJWcsNOs8yxOHcYZjfNks1SdHco6WDuOPh6uUobVx2EdHRExtKU1K49NxyasYikHX3emr4pOdXnNTy6DuJ/U98wSHUa6za9U0zzFBnByTR/b9JPlm7I2sNgZjJyGgTp/q/J/lwpIG0xtQt6lJU+l0tDWot+qaP5gqeR/w3IKphxSgytXOvgkVmwrc+m4z2LxulsP4ltNFcnv97JZsWQGRAeeCXdgt2jcOQT5iAv15M1LxXEJcNi8cc4IBsPu/hzuiNngsyRljHNyxJ/wgAXwMaJi8i491H5hPOnDvNYzI5y95XN6KCc0czVwcbjwvjFzikam+KkGlAA/RNR7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 07:04:57 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::d482:3ee0:a92b:bc39]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::d482:3ee0:a92b:bc39%4]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 07:04:57 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>
Subject: RE: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BMC
 images
Thread-Topic: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BMC
 images
Thread-Index: AQHYqujq7gHIjYALEkmxoc4zW0Gyzq2kxMoAgADlkYCAAHdqAA==
Date:   Tue, 9 Aug 2022 07:04:57 +0000
Message-ID: <BN9PR11MB5483F668B0974343C7FBFB92E3629@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220808053317.3627-1-tianfei.zhang@intel.com>
 <20220808053317.3627-2-tianfei.zhang@intel.com>
 <YvDeGNn5+lx6oPSt@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2208081510260.279137@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2208081510260.279137@rhweight-WRK1>
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
x-ms-office365-filtering-correlation-id: 30a80339-eb05-4acf-6b83-08da79d577f4
x-ms-traffictypediagnostic: MW5PR11MB5883:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+4souVlLm9qhCghDW+SxIyDwOgJcT3r2P7dJwnR3ugudxN9Ia5JBr+TZRwhZLSzuvLrRwvb95YJixY40/jYLXOpBuM46Dp8kn7SoQ3tKE9gzgMeLOFMJibaCm/jfL1W4MiOy6Cq0olAN+InDwZ/5FuCj9Dybdhd2lMeFdvyeU8gQLvMN98zWwaryynHIkPOiWULAI9eU220XGe/tDSHXPYXbKKeS8jjlfh5rlDpFRXf+UU31RMF/MhWLX0zm7KmhaV0gbUW8rb4NSeG/zH58kJkZUbnzsPJF9YT+YJwypJzzvKXhQgF2LayWRrE1n12yLqpzIn8pXH9KXgeNHY1Olv3mkvAEOiwbrYLBTLw3gd/ZKcLt7+aul75DCKQneEuD0a6Gax4OQ2pWXdTm5vRV0h4D97iASx+xS6yy0kwM2RDbJ70CgHBOmlBTfnqSUFNNnfcMZ4xqP2ck4wIo9OF1qMs56HRcnJ1I7oxVfTZfU7sGC7sAFNaQJ8dxHcd4C5WdRvuVBP3lYyRkocj+HyFcTyXB25X3k5hB1xw+gkmlFtgjDTWhJhcFxMXRJ+9hQF7vdWERpPjphQ8y6p4mDokt3IP4WpUy/pjkuJQ/9R4AoPexU3x66K360YdYnsu/SmYOsa9CdPqbpg3YrRUpYTdBRNbklCUJBHq8A3k4dyt1RwcMd/S74XOi5aKqIcCpKHhNAwU98sfo0JRTl2B1hBZ8NZw8NoOXZtU4lWWY+6IL3Iy2Us93QvEbqMVB+XM/NOBMxrUKqxi1WLiDJ4GnClwHLdrgqvAEF5b8qSsdWDT6saJDu9TAI42IyiFSkxDV5HU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(396003)(346002)(39860400002)(2906002)(5660300002)(71200400001)(8936002)(478600001)(30864003)(52536014)(7696005)(316002)(53546011)(110136005)(6506007)(6636002)(54906003)(9686003)(41300700001)(83380400001)(86362001)(55016003)(186003)(64756008)(66476007)(8676002)(4326008)(38100700002)(66556008)(76116006)(66946007)(66446008)(33656002)(38070700005)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pws2BkrrwNpek7DFs+7BcKrM8xTSC7WM7cTIue4POyjigYqTcehgORkWdOjG?=
 =?us-ascii?Q?oGsoZxhJkiO/KrdL30QBLfjMNx89oqnN8WkX2RsZ7aFtE8GiuKUOU6hiM3H1?=
 =?us-ascii?Q?e6RVUp71jMxt8lVnVvW1v6T6xkzaaF3eeMa9ia45da27qPAUFaTSw6pmDq+m?=
 =?us-ascii?Q?D1YgtM4dCco/JaBtWT8L3f5wzv62hGgV/R+zUDAI3qja6TWcm4f46iVuLDkO?=
 =?us-ascii?Q?MuoQjdDkYSODYggLHZTnbOm/5lGwgnS1BUnEL2L0I2tUSheL+A+9v3iLUax6?=
 =?us-ascii?Q?QGI0DXjf5sE7YykPU9hN1y6m52UwF7/cNDYxueU4/YYHbgNx6SXs8zOxObmQ?=
 =?us-ascii?Q?MNuuT68gXhRUSywkiaILp2i3eYkbvSMrqlUTx6kH+XxDUKrvVf+xayDemyDz?=
 =?us-ascii?Q?S4MV7HVygmOHe4rLtZM+zaz46N04ZX3TQo8yqKBm8MYxcbb9S0K9QrQlEsG4?=
 =?us-ascii?Q?Er0peD3w1Ca+mR5OYW11MlNuPbm1iZ0WsIUR36zHZTUb14MGFxu5rQ/Npo5E?=
 =?us-ascii?Q?lmyJh08McRMG85W8KBzrwkY9R2pY9TZnZ12xV2rriqGsW8RhyZkG0QXpckRQ?=
 =?us-ascii?Q?jTFzfNrGiZxnyo1UT/eNZhwPMXwV1i/oQk57riwGEKBT35MzK3TiIuBfyuhx?=
 =?us-ascii?Q?VKVpV3rWG6k4lgoKZT+4rOznZUziw6nrpNZUBXg0cVG92ON9yp0HrFGE439t?=
 =?us-ascii?Q?oaUsyq3hExj7T6jicFd73yh68Va/yelNOFkNG1uaMj5Y+H/cofMGfmqWC5+x?=
 =?us-ascii?Q?YC4pkvfpPatI1YFj8PxdDTyOQirGqKFqJDcQbBWkorFRBnWA5WuMZlFygWjE?=
 =?us-ascii?Q?vtdqlEWtrxCiG6Q8birbuxCxvejlYu4KWaU+nbs75Yr1lx1Cu2Oh5mkfQF0V?=
 =?us-ascii?Q?/FnmYb5A3o6ctd3NNq2QMI972+RhmbkTFQwzfv0K+KP0WeE9q/si5AHMsMeh?=
 =?us-ascii?Q?l01MIfbEKHwtmjfLD1qrvmZZG7DGfu7F/Vl9ckxrgKWZ7nGJZRQsm8PlqWnO?=
 =?us-ascii?Q?W474tfnhR2eQfafd8E1z66pU1lU5CopaN/QLGY84vYx5BGqFIEVxKQkSiWCk?=
 =?us-ascii?Q?wYEwSx9O+p8muwnaPPJ75uagqLSOspwZUldmIwpFsFEE1PLh8cRhUGPogEg3?=
 =?us-ascii?Q?fGlEogvlXSPsmjLM0/QyoIsmq4Pmaqu5334kpakszmtKj4+OqGLDycA1ioqe?=
 =?us-ascii?Q?p/G/lifTf42R3V14sQ8hMtDO4zb12eMmvD+w54eoqO14rkjcXBkITP+5n4sZ?=
 =?us-ascii?Q?m1c5KKtc5VdwV3tJfo609ohuoM+qiuzd3Eto3SYvbe/+8oCPbTau2bL/tb2A?=
 =?us-ascii?Q?jE1koa/Kr9PrcbMooOgNOD09mkSYK71By53G3OytRZGzp5E1+A9V/xz/dz50?=
 =?us-ascii?Q?AazwLLaALz3CgmKwJebqqP7FlypvfZChqouLqyTKBg95r+K6abCGiGesKSuY?=
 =?us-ascii?Q?dVEqV/1nejSJc3swb0KGcLUFrFO9utx1+QyDsqBjEOzW4dPjDuZgZWxkL6p4?=
 =?us-ascii?Q?D0ObReBnXnhnOWSOiT6SUoa8a+ecjNFdvevwfY2vLw95T1i23o8Luucb0E0W?=
 =?us-ascii?Q?XA3Wi6dvMhYKjg79jbENFjTPA+DfUzC44FhLRS8RPU1pi/0sWSKz8elgiRUh?=
 =?us-ascii?Q?y3WT4LVExeSRX2y9Nw5P92rG1CasuczwaiBeijmds6Hd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a80339-eb05-4acf-6b83-08da79d577f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 07:04:57.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tEbMPk4nvGBF+xwppMEDRQ+V3oNwxqoD4lYEBvjRAESwtBgoLBkpGpSTsK9xdiZw7qpMnnM/F6uTPuRiX7oXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
> Sent: Tuesday, August 9, 2022 7:39 AM
> To: Xu, Yilun <yilun.xu@intel.com>
> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; mdf@kernel.org; linux-
> fpga@vger.kernel.org; lee.jones@linaro.org; Weight, Russell H
> <russell.h.weight@intel.com>; Wu, Hao <hao.wu@intel.com>; trix@redhat.com
> Subject: Re: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BM=
C
> images
>=20
>=20
>=20
> On Mon, 8 Aug 2022, Xu Yilun wrote:
>=20
> > On 2022-08-08 at 01:33:16 -0400, Tianfei Zhang wrote:
> >> From: Russ Weight <russell.h.weight@intel.com>
> >>
> >> Add the available_images and image_load sysfs files. The
> >> available_images file returns a space separated list of key words
> >> that may be written into the image_load file. These keywords describe
> >> an FPGA, BMC, or firmware image in FLASH or EEPROM storage that may be
> loaded.
> >>
> >> The image_load sysfs file may be written with a key word to trigger a
> >> reload of an FPGA, BMC, or firmware image from FLASH or EEPROM.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> >> ---
> >> v3:
> >> uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
> >> v2:
> >> adds the steps for how to use the "image_load" sysfs file.
> >> ---
> >>  .../sysfs-driver-intel-m10-bmc-sec-update     |  34 ++++++
> >>  drivers/fpga/intel-m10-bmc-sec-update.c       | 105 +++++++++++++++++=
+
> >>  2 files changed, 139 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> >> b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> >> index 0a41afe0ab4c..3d8f04ca6f1b 100644
> >> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> >> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> >> @@ -59,3 +59,37 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
> >>  Description:	Read only. Returns number of times the secure update
> >>  		staging area has been flashed.
> >>  		Format: "%u".
> >> +
> >> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
> update/.../control/available_images
> >> +Date:		July 2022
> >> +KernelVersion:  5.20
> >> +Contact:	Russ Weight <russell.h.weight@intel.com>
> >> +Description:	Read-only. This file returns a space separated list of
> >> +		key words that may be written into the image_load file
> >> +		described below. These keywords decribe an FPGA, BMC,
> >> +		or firmware image in FLASH or EEPROM storage that may
> >> +		be loaded.
> >> +
> >> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
> update/.../control/image_load
> >> +Date:		July 2022
> >> +KernelVersion:  5.20
> >> +Contact:	Russ Weight <russell.h.weight@intel.com>
> >> +Description:	Write-only. A key word may be written to this file to
> >> +		trigger a reload of an FPGA, BMC, or firmware image from
> >> +		FLASH or EEPROM. Refer to the available_images file for a
> >> +		list of supported key words for the underlying device.
> >> +		Writing an unsupported string to this file will result in
> >> +		EINVAL being returned.
> >> +		It should remove all of resources related to the old FPGA/BMC
> >> +		image before trigger the image reload otherwise the host system
> >> +		may crash. We recommended that follow the below steps or
> directly
> >
> > I suggest we solve this concern first before other detailed refinements=
.

I have run the stress test on N3000 and N6000 card by only directly write s=
tring to " image_load"  sysfs file,=20
and observed  that there are no Host System crash occurred, but the BMC fun=
ctionality failed, I think this is=20
the expected behavior  that is why we strongly recommended that end-user us=
e our RSU script or follow our=20
provided steps.

> >
> > My opinion is, don't make the sysfs interface dependent of other user
> > interfaces, like the following:
> >
> >> +		use the OPAE RSU script to perform the reload for FPGA/BMC
> image.
> >> +		Here is the steps to trigger the reload for FPGA/BMC image:
> >> +		1. disable the AER of the FPGA card.
> >> +		2. unbind the PFs/VFs which have bound with VFIO/UIO driver.
> >> +		3. trigger image reload via "image_load" sysfs file.
> >> +		4. remove all of PCI devices of the FPGA card via
> >> +		"/sys/bus/pci/devices/xxxx/remove" sysfs file.
> >> +		5. wait 10 seconds.
> >> +		6. re-scan the PCI bus via "/sys/bus/pci/rescan" sysfs file.
> >> +	        7. enable the AER of the FPGA card.
> >
> > It is not a good idea the writing of the sysfs node crashes the
> > system, if we don't follow the whole steps.
> >
> > Thanks,
> > Yilun
>=20
> Hi Yilun,
>=20
> The use case being supported with this trigger is the ability to reconfig=
ure a FPGA or
> other programmable componenet on a board without the requiring the HW pla=
tform
> be able to power cycle a PCI slot or power cycling the whole system.  Unf=
ortunately,
> when a FPGA connected to a PCI bus is reconfigured, it can cause a PCI er=
ror.  The
> actual pci error, if any, and any mitigation steps to handle the error is=
 platform
> specific and dependent on the FPGA image itself.  Therefore predicting an=
d
> implementing all necessary error mitigation in the kernel as part of the =
trigger would
> be an impossible task.

I agree with Matthew's comment.
How about we change the documentation as below:

It should remove all of resources related to the old FPGA/BMC
image before trigger the image reload otherwise the functionalities=20
of FPGA/BMC will fail. We recommended that follow the below steps=20
or directly use the OPAE RSU script to perform the reload for FPGA/BMC
image.
Here is the steps to trigger the reload for FPGA/BMC image:
1. disable the AER of the FPGA card.
2. unbind the PFs/VFs which have bound with VFIO/UIO driver.
3. trigger image reload via "image_load" sysfs file.
4. remove all of PCI devices of the FPGA card via
"/sys/bus/pci/devices/xxxx/remove" sysfs file.
5. wait 10 seconds.
6. re-scan the PCI bus via "/sys/bus/pci/rescan" sysfs file.
7. enable the AER of the FPGA card.



>=20
> Matthew
>=20
> >
> >> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/in=
tel-m10-
> bmc-sec-update.c
> >> index 72c677c910de..3a082911cf67 100644
> >> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> >> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> >> @@ -14,6 +14,8 @@
> >>  #include <linux/platform_device.h>
> >>  #include <linux/slab.h>
> >>
> >> +struct image_load;
> >> +
> >>  struct m10bmc_sec {
> >>  	struct device *dev;
> >>  	struct intel_m10bmc *m10bmc;
> >> @@ -21,6 +23,12 @@ struct m10bmc_sec {
> >>  	char *fw_name;
> >>  	u32 fw_name_id;
> >>  	bool cancel_request;
> >> +	struct image_load *image_load;	/* terminated with { } member */
> >> +};
> >> +
> >> +struct image_load {
> >> +	const char *name;
> >> +	int (*load_image)(struct m10bmc_sec *sec);
> >>  };
> >>
> >>  static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> >> @@ -137,6 +145,54 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR +
> CSK_VEC_OFFSET);
> >>
> >>  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector =
*/
> >>
> >> +static ssize_t available_images_show(struct device *dev,
> >> +				     struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct m10bmc_sec *sec =3D dev_get_drvdata(dev);
> >> +	const struct image_load *hndlr;
> >> +	ssize_t count =3D 0;
> >> +
> >> +	for (hndlr =3D sec->image_load; hndlr->name; hndlr++) {
> >> +		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
> >> +				   "%s ", hndlr->name);
> >> +	}
> >> +
> >> +	buf[count - 1] =3D '\n';
> >> +
> >> +	return count;
> >> +}
> >> +static DEVICE_ATTR_RO(available_images);
> >> +
> >> +static ssize_t image_load_store(struct device *dev,
> >> +				struct device_attribute *attr,
> >> +				const char *buf, size_t count)
> >> +{
> >> +	struct m10bmc_sec *sec =3D dev_get_drvdata(dev);
> >> +	const struct image_load *hndlr;
> >> +	int ret =3D -EINVAL;
> >> +
> >> +	for (hndlr =3D sec->image_load; hndlr->name; hndlr++) {
> >> +		if (sysfs_streq(buf, hndlr->name)) {
> >> +			ret =3D hndlr->load_image(sec);
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	return ret ? : count;
> >> +}
> >> +static DEVICE_ATTR_WO(image_load);
> >> +
> >> +static struct attribute *m10bmc_control_attrs[] =3D {
> >> +	&dev_attr_available_images.attr,
> >> +	&dev_attr_image_load.attr,
> >> +	NULL,
> >> +};
> >> +
> >> +static struct attribute_group m10bmc_control_attr_group =3D {
> >> +	.name =3D "control",
> >> +	.attrs =3D m10bmc_control_attrs,
> >> +};
> >> +
> >>  static ssize_t flash_count_show(struct device *dev,
> >>  				struct device_attribute *attr, char *buf)
> >>  {
> >> @@ -195,6 +251,7 @@ static struct attribute_group
> m10bmc_security_attr_group =3D {
> >>
> >>  static const struct attribute_group *m10bmc_sec_attr_groups[] =3D {
> >>  	&m10bmc_security_attr_group,
> >> +	&m10bmc_control_attr_group,
> >>  	NULL,
> >>  };
> >>
> >> @@ -208,6 +265,53 @@ static void log_error_regs(struct m10bmc_sec *sec=
, u32
> doorbell)
> >>  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
> >>  }
> >>
> >> +static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec,
> >> +				     unsigned int val)
> >> +{
> >> +	u32 doorbell;
> >> +	int ret;
> >> +
> >> +	if (val > 1) {
> >> +		dev_err(sec->dev, "invalid reload val =3D %d\n", val);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	ret =3D m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (doorbell & DRBL_REBOOT_DISABLED)
> >> +		return -EBUSY;
> >> +
> >> +	return regmap_update_bits(sec->m10bmc->regmap,
> >> +				  M10BMC_SYS_BASE + M10BMC_DOORBELL,
> >> +				  DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
> >> +				  FIELD_PREP(DRBL_CONFIG_SEL, val) |
> >> +				  DRBL_REBOOT_REQ);
> >> +}
> >> +
> >> +static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec)
> >> +{
> >> +	return m10bmc_sec_bmc_image_load(sec, 0);
> >> +}
> >> +
> >> +static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
> >> +{
> >> +	return m10bmc_sec_bmc_image_load(sec, 1);
> >> +}
> >> +
> >> +static struct image_load m10bmc_image_load_hndlrs[] =3D {
> >> +	{
> >> +		.name =3D "bmc_factory",
> >> +		.load_image =3D m10bmc_sec_bmc_image_load_1,
> >> +	},
> >> +	{
> >> +		.name =3D "bmc_user",
> >> +		.load_image =3D m10bmc_sec_bmc_image_load_0,
> >> +	},
> >> +	{}
> >> +};
> >> +
> >>  static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
> >>  {
> >>  	u32 doorbell;
> >> @@ -565,6 +669,7 @@ static int m10bmc_sec_probe(struct platform_device
> *pdev)
> >>  	sec->dev =3D &pdev->dev;
> >>  	sec->m10bmc =3D dev_get_drvdata(pdev->dev.parent);
> >>  	dev_set_drvdata(&pdev->dev, sec);
> >> +	sec->image_load =3D m10bmc_image_load_hndlrs;
> >>
> >>  	ret =3D xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
> >>  		       xa_limit_32b, GFP_KERNEL);
> >> --
> >> 2.26.2
> >>
> >
