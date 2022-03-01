Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E34C84BD
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 08:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiCAHOS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 02:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCAHOR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 02:14:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB51C60CFA;
        Mon, 28 Feb 2022 23:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646118817; x=1677654817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E/WNEW/QHHg8EMQxgjAIoDVHmI9SAkrswdlxvvcgcJk=;
  b=JrlhxJ4kfJBIz5eDzeKohlQ7AT0sZJokriG8t+RW8sIZuaMu8lJPxfx9
   hNt0sSbw53UE8j5bZhwP5xJ1ZK3BKPej/kPzdMeRFJHy5NHdkvlJbwMrk
   BGgaWCLgJXLP2u1D8JzWObMLZBh+l+rG+gbdvnrcRNS/c9vnPoJalFv5I
   YjgiWVcMlLbJsddcnAxd+zvnqEqEbSHa/k0ipew9XfmjzNIMOuDK5E29i
   06pxlqjMO0mwwSH2Z9v2Qwfp5siD0+opUdTs8wBPMNoYi2ZzSC6NsWr/7
   3W5IniQDs7ACfFrrw2S9biWsruYIlU7SCFZYPSzwF0wAXE2LLSAuUXgV+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316288687"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="316288687"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="534784713"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 23:13:29 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 23:13:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 23:13:29 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 23:13:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx9ru7iC7DGKQEUIMJSTCh/9RQ2FcKlbfPG1C5U9eyM3qtx0A1+Gf8p6z09JUOZqtVG/dJgx/v/L350Oa029uvGHd+EuuUXUnULJoabV8pmgElISyJQH2Baosm42raFIcPWQD46TRR2FBnVzOQpm0X7f/qso4R/k25zWAGtCVydPvpEZxO/u2ORsakZ6ErCpSqRMS6v+pOjFjo1N7DmsNrngh7FILFD/84BzAKVR8zoOXspWNgCe6Y67iUCnh3gM21f5GF2fttr9qbbT88RzfqPGEyJLB7fdBJGLo1lLDBjBCOrojl/vW6NXrZNhH42X4V4T/b+EaFxQNNc5dHoiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWy5Bn5TU6cbQBEdvY0tYfp59k+gMRL9iqJSr4GxDmo=;
 b=E+1Z7oZnBwKWaYIVdfReEn+d20LBsYylzQNNjVRdXgX/KbAAwiB5Ns+/PVnTuYPPjM5EUpdhkGNAn8zviz0RNnAoNPxKwtoHeK46QEHClqqn2i12t2etnSbQLsvJF+ZotTGLM+5ghrYbH39xcvTfgZ64r2oPhNkGkP+ck6lNIoReUttU9FnoYVbC8YQ/BjdtknP2LosA2H3JpAKwbFPEs7/BIoARufqKs3h2L4Uu2sn+No/8/Z29ak0Vc9dOd/5l3BVVqqiKQThxk66Rsxrg6MszbtFi6u1hLp7cCxKcUQ9+kohpyUzO7D9He8sEdXRhfDg+DYybk20l4yuOeMhk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (20.178.231.223) by
 DM6PR11MB2665.namprd11.prod.outlook.com (20.176.97.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Tue, 1 Mar 2022 07:13:26 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 07:13:26 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3 3/5] fpga: dfl: fix VF creation in OFS
Thread-Topic: [PATCH v3 3/5] fpga: dfl: fix VF creation in OFS
Thread-Index: AQHYLTUS/+ljxhhcjkaVJJIxo1vmsqyqGXjw
Date:   Tue, 1 Mar 2022 07:13:26 +0000
Message-ID: <DM6PR11MB3819DB26C00B07D058B7A65C85029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
 <20220301062123.818687-4-tianfei.zhang@intel.com>
In-Reply-To: <20220301062123.818687-4-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 42f938f7-202b-483d-07eb-08d9fb52fb0b
x-ms-traffictypediagnostic: DM6PR11MB2665:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB2665E010F3B49C19162EDD4585029@DM6PR11MB2665.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtUm/8WfO0eUGlyT36djbWuTVJf6efv9jQImGLBQTS6zSSmpFKV4/ypYHNbyvE0MTLVaP72dU9TBMzWr1Vlsfj+i0Xzci3eF/7lG1QcMh54wvj85V+GQAcY2F9K9aFvwW/B/6nbM1IJes6KE4Xo5ffkmQ4eO9v14B3ArMS67nfsYGB1xyfNW/EEHONIDyw09zrEYjJfyHB5mgtgILMngaoERZwNcFtLNDLUFjEDn4onlc1ojXlmBlf5CchG9f76XeYNNLAftAbiB6MrMx8GaudV+/zoYz3ke/v8SR8TEkXGvW9rTiCjYH49ZKX8HsTZSvtg+GGoJqHtF+a5w+vM1yE3cEG2v5Lwgaf71Q1B6zetH7PKvzZ/K1iJHzJwlt7qcwonQUpmkjKY5apMuJXsrN8UMSMjN4FbjJCip5YjcCMBzPRFaGQyXorsH1VvtMfC46ofr/MrE1On8QTf/aEZZtDNksZc1xn+PZYoOHGicXF7U7ZcQ+EsVkqDu1qnOJhvZABorzcUd6wxUqRDgDvF8PCE6rpCdQmn3GkZrvkDCztXiVwNPL1fPhM1Y/SnUpM1QulSyGpRNjdBTzigWVLBkiUxb5vq+VGbgTQeWnH2CdEiDFsFExtrRJnk4tpWZ6BY6lJuqem20hLjsPoceWjrGlkgBTwlrl+6PybUScMqujbwt2r28YPz2ixmzLsmjTKotgLKKZJMGUzJi9Uz53xo5ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(71200400001)(508600001)(55016003)(6506007)(7696005)(26005)(86362001)(186003)(38100700002)(33656002)(9686003)(82960400001)(66476007)(66556008)(66946007)(64756008)(5660300002)(76116006)(66446008)(83380400001)(8676002)(4326008)(122000001)(8936002)(316002)(2906002)(52536014)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uMnk7MwrFjI21xJoQ5cu+smErRUoq7QtpokzdKFAKXA+UxAkfVDgLXD3Ob7k?=
 =?us-ascii?Q?jr5chgvjYivf5fwIfhynNhyLqXiTJik8mCmVQSdP8UvNiMX8OjwbmgZTYBP7?=
 =?us-ascii?Q?lVwGSGgIQDyX3ks8IwCNDqP2lSsLfRYdTRt/5YKtPssfUecOXZ7eql+bji3Q?=
 =?us-ascii?Q?Ornht25h00E+D63inctbprmEwDs4t0LSJksMNwHGWXr6WrZU742agwxaNQbH?=
 =?us-ascii?Q?oWNrTKLKH98u4xNDa8iluvSM3T3Dl7TwcZg9tR4G3pWw66EwJFy/0h4kbTZk?=
 =?us-ascii?Q?XjI6SoVBtl7L6wO6CVTjIsbT6ose0WUyajILdW2SzfQ7C67TC/lv81jEck6P?=
 =?us-ascii?Q?fLqiMQQrBsH/07TzIrHnpjXEPVXuDYzzFXfLqM6OYxAj0ojnJDX1xFZ7CGSr?=
 =?us-ascii?Q?6CbJp3EFNtmWiWLPD43C8Q342ybtWKgfc967tmxVPr5DVy4UFZXJ2Bwj7TbT?=
 =?us-ascii?Q?R7fN0tVxymrzI6MW80EJIJCZ5Py7dipI0fyljYP/f6a65EY4IPcIISE399t5?=
 =?us-ascii?Q?65lzn7eLeoBEn3mX8Tm35OEljwrACChTRgjSEYqWCDydNXD6UzBhc2n5RKi5?=
 =?us-ascii?Q?TKuGXWUDxWmXiVLJ7m1Y+oqXcBmlEN4NEd2Dn67whJ9NPHnGAAS7eU89O0R2?=
 =?us-ascii?Q?1jeQlcfpIYeqqpqdH0KfpTonJRO7uwyQ6fcNIYAHZXvGWPwiuUdKgVu2PzSs?=
 =?us-ascii?Q?Vl4BdugTo92lWYTfj3aIu16CT3xoMG1ZtK+o0UM/L+Hexa5EfphY9FSh3Zr2?=
 =?us-ascii?Q?yQ4ixCwxRPZiBBhslJ9mFxvpyZCKI0Ofi60i54yZpVB0SHcrMuqRNdiPXVmn?=
 =?us-ascii?Q?Ia6VNM+58SRklYOcLz8Xyr2Q/C5XCG6fz974sQYLVHvLitrMDJwoOiSDdBq+?=
 =?us-ascii?Q?UXEa4DfDIuJXAdFU/Uy4xoFtZ9xPDbE1e8AyHXaIpfALtZ6+HF3pW4G+ADq8?=
 =?us-ascii?Q?v6JIn/jcF4LNg3JiVEZ9XVdFlBOsMa6hDSswNuxjJq83/S4yyJwhZdyeJ31O?=
 =?us-ascii?Q?ncHbocLcarXC192iGEM31V4MdZUEcYTrzHXltaiE4xhlJKwZXAUBNJ8mBvZj?=
 =?us-ascii?Q?Hznnfu4sCfTndkaYkNHtglU2KrlBKHiWLs1fMJcBJ88XZ5HdNTteSUSkrlfH?=
 =?us-ascii?Q?V2MS7yByDWJf9Dc4TSPJP27JNKeaiDFLrYjH1M4QmfwbuVK0H2AUQGnOx4lM?=
 =?us-ascii?Q?orY0t6+AqtIFyLyPpDaWflmPqDMvQ9FF0aAFqGc3mlQFPxdfb1JbXpThthTX?=
 =?us-ascii?Q?ALCBlDuPhMjru6yvda8jX6YHylDMtqF9TUMYhlt8dbPXYfn/smP95SgwB0nA?=
 =?us-ascii?Q?eiFb8vJ8q+gcaIOw2Mgc2aokPBXbKW8qwCIzG/47/6RhPmzgsmi35FgEJ2aG?=
 =?us-ascii?Q?+lnJa04UdP8LtXSkLF7QyWySxgeJ9hYt0ro2Tr8LEo9l+bdSMuXucp6cO/0F?=
 =?us-ascii?Q?Atupj9aJUNI6P0W/EFhl9ftng2V/XpRmWzshrJ3ioaV4FuWfgbLU0sYT3vJn?=
 =?us-ascii?Q?n+eXKYXG2vjJ+P2rvrlT+3NlcK+UFGYnyRQgMf8oKD6EQkFKJs8/yNxeb2xB?=
 =?us-ascii?Q?TWiieGBe13iaV7izboPsBcfbCm9eehEzQeh5QYhUIIxvvi74w+ggocvZVxRt?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f938f7-202b-483d-07eb-08d9fb52fb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:13:26.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kNaqfWid9aFuZlJn3bXviki84Z7Qw9oTBIXKmzphbdUkDg4/IeuLHn3yUeZJ84Nifty6CSxzLgzQ74iSdkCNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2665
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3 3/5] fpga: dfl: fix VF creation in OFS

Why this is a fix?=20

>=20
> In OFS legacy model, there is only 1 Port device related to
> 1 VF, the flag DFL_FEAT_PORT_CONNECTED_AFU will take notes for
> this model.=20

What is OFS legacy model? And what is legacy model? They are
the same or not? It's quite confusing.

> In legacy model, it need to check the released port
> number match VF device number or not. But in "Multiple VFs per
> PR slot" model, the Port device would not connected to AFU/PR
> slot, so we don't need to release the Port device before creating
> the VFs.

I think the major difference here is not that PORT has AFU or not, but
If PORT needs to be turned into VFs. Would it be better to be decided
by FME registers controlling the access to PORT?

If we consider following same flow for enable SRIOV to reuse existing
tools, then we need to add FME flags to indicate user (and dfl-pci),=20
no need to assign/release port for SRIOV enabling.

Hao

>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 5872031c2e9f..fd04ef5c8b03 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1702,11 +1702,13 @@ int dfl_fpga_cdev_config_ports_vf(struct
> dfl_fpga_cdev *cdev, int num_vfs)
>=20
>  	mutex_lock(&cdev->lock);
>  	/*
> -	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
> -	 * device, so if released port number doesn't match VF device number,
> -	 * then reject the request with -EINVAL error code.
> +	 * In the OFS legacy model, it can't turn multiple ports into 1 VF
> +	 * device, because only 1 port conneced to 1 VF device, so if released
> +	 * port number doesn't match VF device number, then reject the request
> +	 * with -EINVAL error code.
>  	 */
> -	if (cdev->released_port_num !=3D num_vfs) {
> +	if ((cdev->features & DFL_FEAT_PORT_CONNECTED_AFU) &&
> +	    cdev->released_port_num !=3D num_vfs) {
>  		ret =3D -EINVAL;
>  		goto done;
>  	}
> --
> 2.26.2

