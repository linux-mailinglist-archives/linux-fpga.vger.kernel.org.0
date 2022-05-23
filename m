Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2435307B9
	for <lists+linux-fpga@lfdr.de>; Mon, 23 May 2022 04:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbiEWCeP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 22 May 2022 22:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbiEWCeO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 22 May 2022 22:34:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A5D107
        for <linux-fpga@vger.kernel.org>; Sun, 22 May 2022 19:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653273253; x=1684809253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E1Q0YTQsdPdpBDHfURe74wgneoN2DsDjc6At+Dy8X6o=;
  b=ftuMJwig1D0wY4QrgR2VM1bMxEyCg7/1bzsP7j6BED8esQX0osB4wW+O
   qgR/cOih9YwWhFXWFrckfPItfhNBRVD1lGr/CuQ+jDu3DffjTXufgzkkp
   IQnwt06IZ5v0ECh268fodbwEn5YDxL8LJIBJvNBgRp0aoxMIq9IPCY7wY
   xjGJC1AaoNq5W3f1SmSEtDvnPQaS8Xy9Sb6tLZ5ydvmdXLA9+Fba2YB8k
   0nQj1T6sqLvOXxnKrfi4oi6FQesuZ15Hnhvz9sUqnIzNIdQnEur2kWM8M
   RyOyppiIWWsFvIMydxZdAaFhnIp39+5V/X4ZSLKj/1qfwdAiwoBmB13tN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="271897498"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="271897498"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 19:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="744472284"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 22 May 2022 19:34:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 22 May 2022 19:34:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 22 May 2022 19:34:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 22 May 2022 19:34:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 22 May 2022 19:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tit7yj6FdafXd7pP4rKLWiiUJbZVLaoLKA9Z/lbnul9lyRhui3sEQuwMSXXldsP+dyyYn2BrOZPFumvX2OZdvoDz968j3w8HlwIiTKWlXqg52eBR37YbM0XFZaIyT60n3JZmlsy1jMOQVsHxUAdnTX0jNTCx6z+Prpzsn6uzawtRuWHZIZfWNE7xEMSHUxuaQVGZJpzwHeclBGW6UycTSv824hhMU5zYPRFrcKgMJxSwSLtmZ1dVO2kEgSD0BPg9rGckbuI9561PTbPOUJ4n6vG5lx6mjYewwBQ5TXeh7Jpo7ZMlG2fURt8631i+S+WJKIQiUSfSCCs3MW1MgqsULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiqLg0TwZTaBR0N+SAavM2WuTFOvqi4oyhkyQlkBv7I=;
 b=mF+HlayV/T2EYvuq2EBr0EaUuxpZrPZAb8rVilo/ImcfzUTvr6cT9l4AKT+Ndq468fKYVLgLU12xR4CAkmXbSD0QvjDtNWDcvYbQXD3MPvmksaCJuki1+M3KPlWKtbuasSEUuBZac6S+F2vWYxQbHfoeVit/O+4DOSoYEPr5LtigyB0AdxqGiFaaR/6CNyirs6kEOWPW4IzqyktWQt5y2+6a4nHhMXvNnvArhqffmmijP/fS/KIuUHSZUu9KuB5agDgD+IsNR9Ru1G9A158XdQSFl9j4jucGjPs3HGv95n051vdEQUtyZ1vj/Uxq50i/TR94RUJ3mp4Lu6VZNKRbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by PH0PR11MB5610.namprd11.prod.outlook.com (2603:10b6:510:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 23 May
 2022 02:34:04 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::4d94:5d8b:51d7:d8b4]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::4d94:5d8b:51d7:d8b4%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 02:34:04 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "marpagan@redhat.com" <marpagan@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Muddebihal, Basheer Ahmed" <basheer.ahmed.muddebihal@intel.com>
Subject: RE: [PATCH v21 0/5] FPGA MAX10 BMC Secure Update Driver
Thread-Topic: [PATCH v21 0/5] FPGA MAX10 BMC Secure Update Driver
Thread-Index: AQHYbKrN97piyWzg40O9t1VEcwxYLa0rwOFA
Date:   Mon, 23 May 2022 02:34:04 +0000
Message-ID: <BN9PR11MB54831DE841158BD874126462E3D49@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
In-Reply-To: <20220521003607.737734-1-russell.h.weight@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7dee433-b2af-40a7-47ad-08da3c64b475
x-ms-traffictypediagnostic: PH0PR11MB5610:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5610926F3D27D82E432DCC9BE3D49@PH0PR11MB5610.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WvP06K/VKphu3EYfzhVmLgJNfoT9udlQzIq2xPox+5izS5DW01lFqyc0yhNb86LVQZPRXOqBKHGUTRl77B9iwevs53fkGcnqhW3Lqd/tDlHlGoAMnuo5Jl7ugy+DRSPwupgPQRTW14JlenrNQ8kYBGJeoP6OxOFkmDQAaIOvy0ysasT2YUr567UqsCFD1zfFGptzPG0W46shNNbklSjMUMALlMClp96exU1W5RbrLkyMfC3AxFpEZSYapNCpc26N/LZrhKioZtfFiWUm6/gWGLiki78cOH67hQornbiElWXzO2HToDzxKJWCYxFGPbiyPK14WpF5mwjZdbS3oH/5QSLJfzyileSYFcnDh0twPdudc0yIhwRCPFIPsnDmzIOXw7fj9dD25t8tNUMTTr80CM0ca/eSWIEe4HA9GrTgAtmqEAM2UqwcfUWbgY4Ac3SCPo2kKjMdVM4iD3DjM4tt0bDBSQlfxaRwcPKUFKfZ8FleGo54cjcr2J3cWA6AL70eFXiRa53CioPkNgPeVDy7UNXNDnR9/784VRQAG8WFnND8vzXMzUz00lS/DUwwS7JAJGGMcYJVCwKh68I/5sHWcOKpm7gfk8+vmTsrprjITy4tnj7hGL6UWS5R/mSgsi+i+PUJ6MBqo4wnqPWA6EokQ/LqVZ1m7IHNdvcMzxbVmm2TDPx0LJeXFEPYJQR8Ci6RNBu3zsAGupskTwxXw90DzDvj5UBaQLi0qfGbvYptubSrjMD8gvqDqK6wMCKefUkZ0rfWJ/rd22vA2oyS7+u6xRmsPoQhO8VE82rT6FK88dU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(15650500001)(30864003)(2906002)(186003)(33656002)(76116006)(66556008)(4326008)(86362001)(64756008)(66476007)(5660300002)(8676002)(66946007)(52536014)(8936002)(66446008)(53546011)(9686003)(54906003)(508600001)(71200400001)(55016003)(26005)(122000001)(7696005)(6506007)(38070700005)(316002)(38100700002)(82960400001)(110136005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?el3WsXiey19bxbPWJ5bReNa+bW9HqzDPp037lI2XwAxAEL8sGRqoR+sRLWi+?=
 =?us-ascii?Q?Pmgm0Ok3omGBBJGXNp7XsGsuDIBsbT/0ejR5qjzHdI4WI1goRh7LLpCMPG0M?=
 =?us-ascii?Q?Hn3LU4eEVllempvLpJk+UVt1fiTovIg3sPBGT+2P/JNvT92PPmn8mDzHF9Pj?=
 =?us-ascii?Q?Hz15SwjN3cHSoi/fUS0mmgEIcvWa7+bvtzSP+8m3Esi0mwDeFCivgThWAN7O?=
 =?us-ascii?Q?sduHgMfjzGcfjIp5op7AVExdNYsp4kMOGaKt4T/VAqvAMtR8zNINWXhK7UVk?=
 =?us-ascii?Q?Ha7gpqGt0KDDdmKV80Gqm0hsCBUfXe6AlwrkdOazh7fF3l0fF9WEqx/5d056?=
 =?us-ascii?Q?9FPCd7nCjHoZASzCZJQWjLBPKYbEa32Tt+GuSzdh77Bdxsl3ZNc2EWbsPzGv?=
 =?us-ascii?Q?Gu6SZVNaJWERUOerpEnHn+EFn8Ik715873WzwlUsxZzvQ1qRr5UtS8UpGkfn?=
 =?us-ascii?Q?o81b+sPyekeUC/m99QaCyojYUq6OVKh4B+Em1Mxm9BAnbe6FxRvFVNGeMqSH?=
 =?us-ascii?Q?BQ5Yly+XrBbe2F4hnUgvhMpt9HkO9P8365+YPDKY6bqI8eUmrKXFwtTF0Owc?=
 =?us-ascii?Q?ft0pRgrRn2OEvCjhT3W3JewBLV2MRsS3wj2XszF8X8P6JVu9dg7sKIBF3KNz?=
 =?us-ascii?Q?2gmRTVAHJ9TaqMHkBd8cV073PvzGY2hZXFo9+O7lo925u+vRPp0AJF8dY9Ey?=
 =?us-ascii?Q?Jg8ZnIq5gswGbiTTjjU3hPD//I4UsaanhpJHRpFR8lwV9/Z4LKd4g8kgZzav?=
 =?us-ascii?Q?TO1rdkO08ASjJLHc0vv/XowKmfRzozcHA/VVSFZz0TeREddlwR1SPj9dJ1S1?=
 =?us-ascii?Q?qzvWYeQ+eQ5lXGWZb06Uu972Q5C+nbeviNU/roNBvH32piix3z0aaMlzRDIV?=
 =?us-ascii?Q?hGETI4GyyZZoSy1PlQh8Q4xn4jSTwHvi04M+c/XuMLNKbXVl3fC/acfEAaFt?=
 =?us-ascii?Q?XMkUDKC/WAD6mvQ46JWyNyXue7A/lHtaNKox9sjlbBT54jOpv0d5oZLu49/I?=
 =?us-ascii?Q?cwAF3JJkOAJ5c51heOdgWFUfCStRY9QLh6vrrpAXxtGxWa1G7fw786ECuFWy?=
 =?us-ascii?Q?h4zf9YCm1scW80rgky5z2Gt+4mx85c3Ng5xuSZSImBPd++AjUjOf8jOvQzUl?=
 =?us-ascii?Q?x3FOndyfrtM0yddNjl4dD0cJYF+70aLRrr4q9V+GOtU2lsxm/2zf2zPmraft?=
 =?us-ascii?Q?6dUhp1ZQGAPgoMvtVExcSpo1jbpQLt15HeDwjrZYgZozNjmUk6FHTLTGYyV2?=
 =?us-ascii?Q?BGsJ2AK+MSGZoYC3gbJEDYKjZid7t2LzOwjEVXYBPNwupdMLP5zOgxsO/H1J?=
 =?us-ascii?Q?GrxjsSsDCsuOSM/bG9WqKT+2Z5TRSHV8anPvEXXkuhY/QNiEZnH1NHpM1eXm?=
 =?us-ascii?Q?tpkYtOlWjFceZYu7Mk43Sm/Hg/ygnIPmfcSp8uJYApzB6uegNlsiHLYZMyyw?=
 =?us-ascii?Q?LyP3yBcxn93QXwA8//rOjnVV18dvLzPEndGBaHIBfAW37YgnGMDhT/3m9elM?=
 =?us-ascii?Q?Xr/yg+Ew8QGqZxjPYuu8oBAH8RuSfqGODxo1mqc94UYF5oXgQfmWyUcWKrfy?=
 =?us-ascii?Q?hkAlGNs/DSGuN7wx7vqkoSH/vXZZkYOnhfWVyFsab8xHNSQCCrQh6I/90Um8?=
 =?us-ascii?Q?lLO13GGW356ZUtrg6rWNlK9vMcH5jKOfLqxyvCtzw0SerDxR38aWUaaob3/9?=
 =?us-ascii?Q?EcIP4kSXzs8qtRK8JXid1bQQ0iV3XWiRnH90ZMKr0sDwLcv0IMms3SVWConf?=
 =?us-ascii?Q?452eS/1LVA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dee433-b2af-40a7-47ad-08da3c64b475
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 02:34:04.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qnRmvSK15NTxfk/HBuG128kDyVLF5ZKUVAA0gXPDFichxpHPUcQVTwovxLjiz10jJk4ZV7Tzrn/PR2N03dJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5610
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
> From: Weight, Russell H <russell.h.weight@intel.com>
> Sent: Saturday, May 21, 2022 8:36 AM
> To: mdf@kernel.org; Wu, Hao <hao.wu@intel.com>; Xu, Yilun
> <yilun.xu@intel.com>; lee.jones@linaro.org; linux-fpga@vger.kernel.org; l=
inux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; marpagan@redhat.com; lgoncalv@redhat.com;
> matthew.gerlach@linux.intel.com; Muddebihal, Basheer Ahmed
> <basheer.ahmed.muddebihal@intel.com>; Zhang, Tianfei
> <tianfei.zhang@intel.com>; Weight, Russell H <russell.h.weight@intel.com>
> Subject: [PATCH v21 0/5] FPGA MAX10 BMC Secure Update Driver
>=20
> The MAX10 BMC Secure Update driver instantiates the new Firmware Upload
> functionality of the Firmware Loader and provides the callback functions
> required to support secure updates on Intel n3000 PAC devices.  This driv=
er is
> implemented as a sub-driver of the Intel MAX10 BMC mfd driver.
>=20
> This driver interacts with the HW secure update engine of the FPGA card B=
MC in
> order to transfer new FPGA and BMC images to FLASH on the FPGA card.
> Security is enforced by hardware and firmware.  The FPGA Card BMC Secure
> Update driver interacts with the firmware to initiate an update, pass in =
the
> necessary data, and collect status on the update.
>=20
> This driver provides sysfs files for displaying the flash count, the root=
 entry
> hashes (REH), and the code-signing-key (CSK) cancellation vectors.
>=20
> Changelog v20 -> v21:
>   - Replace WARN_ON() calls in flash_count_show() and show_canceled_csk()
>     with a more elaborate test. Return -EINVAL and write a message to the
>     kernel log. Call WARN_ON_ONCE().
>   - Update m10bmc_sec_prepare() to ensure that the base address for an
>     update image is aligned with stride.
>   - Update m10bmc_sec_write() to handle a block size that is not aligned
>     with stride by allocating a zero-filled block that is aligned, and
>     copying the data before calling regmap_bulk_write().
>=20
> Changelog v19 -> v20:
>   - Added text to commit messages to describe Root Entry Hashes (REH) and
>     Code Signing Key (CSK) cancellation.
>   - Use reverse christmas tree format for local variable declarations in
>     show_root_entry_hash().
>   - Remove WARN_ON() from show_root_entry_hash() and return -EINVAL if
>     sha_num_bytes is not a multiple of stride.
>   - Move MODULE_DEVICE_TABLE() macro to just beneath the definition of
>     intel_m10bmc_sec_ids[].
>=20
> Changelog v18 -> v19:
>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>     with the parent driver.
>=20
> Changelog v17 -> v18:
>   - Changed the ABI documentation for the Root Entry Hashes to specify
>     string as the format for the output.
>   - Updated comments, strings and config options to more consistently
>     refer to the driver as the Intel FPGA Card BMC Secure Update driver.
>   - Removed an instance of dev_dbg().
>   - Deferred the call to firmware_upload_register() to a later patch
>     where the required ops are provided.
>   - Switched from MODULE_ALIAS() to MODULE_DEVICE_TABLE() in anticipation
>     of additional cards to be supported by the same driver.
>=20
> Changelog v16 -> v17:
>   - Change m10bmc to cardbmc to reflect the fact that the future devices
>     will not necessarily use the MAX10. This affects filenames, configs,
>     symbol names, and the driver name.
>   - Update the Date and KernelVersion for the ABI documentation to Jul 20=
22
>     and 5.19 respectively.
>   - Updated the copyright end-date to 2022 for the secure update driver.
>   - Removed references to the FPGA Image Load class driver and replaced
>     them with the new firmware-upload service from the firmware loader.
>   - Use xarray_alloc to generate a unique number/name firmware-upload.
>   - Chang the license from GPL to GPLv2 per commit bf7fbeeae6db ("module:
>     Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
>   - fw_upload_ops functions will return "enum fw_upload_err" data types
>     instead of integer values.
>=20
> Changelog v15 -> v16:
>   - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
>   - The size alignment check was moved from the FPGA Image Load framework
>     to the prepare() op.
>   - Added cancel_request boolean flag to struct m10bmc_sec.
>   - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
>     rsu_cancel() function.
>   - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
>     The cancel_request flag is checked at the beginning of the
>     m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
>   - Adapt to changed prototypes for the prepare() and write() ops. The
>     m10bmc_sec_write_blk() function has been renamed to
>     m10bmc_sec_write().
>   - Created a cleanup op, m10bmc_sec_cleanup(), to attempt to cancel an
>     ongoing op during when exiting the update process.
>=20
> Changelog v14 -> v15:
>   - Updated the Dates and KernelVersions in the ABI documentation
>   - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
>   - Change CONFIG_FPGA_M10_BMC_SECURE to
> CONFIG_FPGA_M10_BMC_SEC_UPDATE.
>   - Change instances of *bmc-secure to *bmc-sec-update in file name
>     and symbol names.
>   - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
>     names.
>   - Adapted to changes in the FPGA Image Load framework:
>     (1) All enum types (progress and errors) are now type u32
>     (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
>         and uses *blk_size as provided by the caller.
>     (3) m10bmc_sec_poll_complete() no long checks the driver_unload
>         flag.
>=20
> Changelog v13 -> v14:
>   - Changed symbol and text references to reflect the renaming of the
>     Security Manager Class driver to FPGA Image Load.
>=20
> Changelog v12 -> v13:
>   - Updated copyright to 2021
>   - Updated Date and KernelVersion fields in ABI documentation
>   - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>     functions instead of devm_fpga_sec_mgr_create() and
>     devm_fpga_sec_mgr_register().
>=20
> Changelog v11 -> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
>   - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk(=
)
>     no longer has a size parameter, and the block size is determined
>     in this (the lower-level) driver.
>=20
> Changelog v10 -> v11:
>   - Added Reviewed-by tag to patch #1
>=20
> Changelog v9 -> v10:
>   - Changed the path expressions in the sysfs documentation to
>     replace the n3000 reference with something more generic to
>     accommodate other devices that use the same driver.
>=20
> Changelog v8 -> v9:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
>=20
> Changelog v7 -> v8:
>   - Split out patch "mfd: intel-m10-bmc: support for MAX10 BMC Secure
>     Updates" and submitted it separately:
>     https://marc.info/?l=3Dlinux-kernel&m=3D161126987101096&w=3D2
>=20
> Changelog v6 -> v7:
>   - Rebased patches for 5.11-rc2
>   - Updated Date and KernelVersion in ABI documentation
>=20
> Changelog v5 -> v6:
>   - Added WARN_ON() prior to several calls to regmap_bulk_read()
>     to assert that the (SIZE / stride) calculations did not result
>     in remainders.
>   - Changed the (size / stride) calculation in regmap_bulk_write()
>     call to ensure that we don't write one less than intended.
>   - Changed flash_count_show() parameter list to achieve
>     reverse-christmas tree format.
>   - Removed unnecessary call to rsu_check_complete() in
>     m10bmc_sec_poll_complete() and changed while loop to
>     do/while loop.
>   - Initialized auth_result and doorbell to HW_ERRINFO_POISON
>     in m10bmc_sec_hw_errinfo() and removed unnecessary if statements.
>=20
> Changelog v4 -> v5:
>   - Renamed sysfs node user_flash_count to flash_count and updated
>     the sysfs documentation accordingly to more accurately descirbe
>     the purpose of the count.
>=20
> Changelog v3 -> v4:
>   - Moved sysfs files for displaying the flash count, the root
>     entry hashes (REH), and the code-signing-key (CSK) cancellation
>     vectors from the FPGA Security Manager class driver to this
>     driver (as they are not generic enough for the class driver).
>   - Added a new ABI documentation file with informtaion about the
>     new sysfs entries: sysfs-driver-intel-m10-bmc-secure
>   - Updated the MAINTAINERS file to add the new ABI documentation
>     file: sysfs-driver-intel-m10-bmc-secure
>   - Removed unnecessary ret variable from m10bmc_secure_probe()
>   - Incorporated new devm_fpga_sec_mgr_register() function into
>     m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>     function.
>=20
> Changelog v2 -> v3:
>   - Changed "MAX10 BMC Security Engine driver" to "MAX10 BMC Secure
>     Update driver"
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
>   - Changed "_root_entry_hash" to "_reh", with a comment explaining
>     what reh is.
>   - Renamed get_csk_vector() to m10bmc_csk_vector()
>   - Changed calling functions of functions that return "enum fpga_sec_err=
"
>     to check for (ret !=3D FPGA_SEC_ERR_NONE) instead of (ret)
>=20
> Changelog v1 -> v2:
>   - These patches were previously submitted as part of a larger V1
>     patch set under the title "Intel FPGA Security Manager Class Driver".
>   - Grouped all changes to include/linux/mfd/intel-m10-bmc.h into a
>     single patch: "mfd: intel-m10-bmc: support for MAX10 BMC Security
>     Engine".
>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>     the single call to ifpga_sec_mgr_register() into two function
>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
>   - Replaced small function-creation macros for explicit function
>     declarations.
>   - Bug fix for the get_csk_vector() function to properly apply the
>     stride variable in calls to m10bmc_raw_bulk_read().
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>   - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
>     ensure that corresponding bits are set to 1 if we are unable
>     to read the doorbell or auth_result registers.
>   - Added comments and additional code cleanup per V1 review.
>=20
> Russ Weight (5):
>   mfd: intel-m10-bmc: Rename n3000bmc-secure driver
>   fpga: m10bmc-sec: create max10 bmc secure update
>   fpga: m10bmc-sec: expose max10 flash update count
>   fpga: m10bmc-sec: expose max10 canceled keys in sysfs
>   fpga: m10bmc-sec: add max10 secure update functions
>=20
>  .../sysfs-driver-intel-m10-bmc-sec-update     |  61 ++
>  MAINTAINERS                                   |   7 +
>  drivers/fpga/Kconfig                          |  12 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/intel-m10-bmc-sec-update.c       | 640 ++++++++++++++++++
>  drivers/mfd/intel-m10-bmc.c                   |   2 +-
>  6 files changed, 724 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>  create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c
>=20
>=20
> base-commit: 18ecd30af1a8402c162cca1bd58771c0e5be7815

Hi Russ,
I have tested this patch set Intel PAC N3000 card, it woks fine and this pa=
tch set looks good for me. You can add:
Tested-by: Tianfei Zhang <tianfei.zhang@intel.com>

