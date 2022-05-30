Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B348537396
	for <lists+linux-fpga@lfdr.de>; Mon, 30 May 2022 04:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiE3Cfc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 22:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiE3Cfb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 22:35:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8740072E31
        for <linux-fpga@vger.kernel.org>; Sun, 29 May 2022 19:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653878130; x=1685414130;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=F6KJCIc1UHv31uJaf94UKuMcginIDQjWST1TUWkbd24=;
  b=Bb8VYaj7vdQTMIgAVbqJb5o1rCJp4cU5L+v4mocpiDqNGt/0UQsBGyxl
   TkocctGtezYBLbBrDRdYw0c7HX2RAKbfdL4iR6aou7FPwHuwWUezVcVxC
   x2MNuoQjxSAZi9v3+KdsdtIAegJiElOI41ujhoDSJvDVJU5wR6eCMP9SY
   Bui7K3qgwVFOI49PeSempcFiQ8UuYZTQHNertIil7rFHkx8vc9aJ/WwR5
   xUIhv11+PG78gYJjc/ovqpjdtCYRLwxorlR5KsEgGdNLWoQoQcI58XA+/
   e32nYET9UB5Dplu9pWa8e2o0Zz1hOhqsvoANwUzhgVOIsf5w7XCpFUh0i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="274876360"
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="274876360"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 19:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="903361828"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 29 May 2022 19:35:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 29 May 2022 19:35:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 29 May 2022 19:35:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 29 May 2022 19:35:29 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 29 May 2022 19:35:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4OonGU7dpWBi+sth2VQsUPDP/E0rWL45BBNwfRC36J0yMC42pJ8RlPxcoW5afsOxhNzsVt1m0AuUZv5uEN6BV6eGpmAr+3f68UvI0GHSpSgyHvs0vEyhEEIK7yyZaQOXgrJ/z5lWhZkPwooCOFfzrjPwMz53MG1+gW6xVJk1rE0aX2xCkN+ks33fzTPzbgh2F7Pt3H/hS2z0cS6pYwFZweX7Tj9LDtpP18uKrR7uxEfD6jKZDNIhtsINZjbfRP36BB0HRUSlg8Yd0NUp5+/++n/h8K6pKZpFO66n47zxLwcB7ponvpokkfZXIz67hoAWLDxijCiKGcJKYCaN/Gf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NemdehXM/1dM9NtR25gv+/Z/NSsgTAfPne2n7vcjU4Q=;
 b=Cy5MsA7C94UO6hXT55aeEYAfP2aob7APjYfnKmxIcoGNoCUkf+6d0sBktytRJAyfHZ/9YMZJFVZvMWEMvW4yiy1dpiOObdECPSRoSof/5jctPAVUG/2nu2pECd0xSHBNkvUG1EgW9b4tCy1gMnuOztPJdI3zQ0c/cd4haYGmjqNl8jvyVbBFNvdDKmmtM/mW63BjAvEJyr8Nx/iFXwm2suWOPXbWvkAEoVAcmy4jNQpmcJONw0BGUsV8iV97HhUsRp7O1p2mz+6O3rKWcjFltlzorT8XU+UXEj4SUUMN+dGDGes639GKfgFEK+fRQz1hmkm1uzVnJADAsEtx1pWuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by MN2PR11MB4534.namprd11.prod.outlook.com (2603:10b6:208:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 02:35:27 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 02:35:26 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v3] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Topic: [PATCH v3] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Index: AQHYcZx93FHtj03kI06vUfRyEn78pK02sjcg
Date:   Mon, 30 May 2022 02:35:26 +0000
Message-ID: <DM6PR11MB38190615C0847C763ECF030085DD9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220527073253.306501-1-tianfei.zhang@intel.com>
In-Reply-To: <20220527073253.306501-1-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9a52823-9934-4c0a-18b1-08da41e50e12
x-ms-traffictypediagnostic: MN2PR11MB4534:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4534B369124F665BA54E2FCA85DD9@MN2PR11MB4534.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDMMHqJqGZPSctGjFtAjObKhLtn5QOS63+dUPi2YTVyHxchJzRQPnjslfHnP9njA9cZ98eJxNTbS9We+knktp3lL/4ORvAyuz4/HnxYoI48QfjD+4Cjym4lB9VWqm188f7sT3HUz3le2Aj79IKpfuw87mqXqB2+B2p/BvC170vQaiFr+Z1TAIU6+0KhXJgYh40XCM71GEK7HPnsMxr7mh2A1ffevM3ST14w//3LdvAmy9dOfQkjq0HCtR1RwK1gIJTr5zRWB1gOsDHp79Fl48pLeukjQXrQioMNQlF17LM5dXEP6dpbLsREGsmuaJn8iNL9z78InbgQ7F1sA4HiA0is0Lxtf3Ze/bKv+Hls+/RP4vvDszcveAN1+BowzCtbhi/8LOvNe4Oib6/zq/eTwpPSSoBQbGy7MZS3pB4t43ImQcJmzt7eIC79jnV1UlddroQA2uOmXNAJwADwnifSezpPiQc/VQoltad2cIwVgqAcV6zqIWfqJ0IrhWw6ycDkX6mZwab+Tq7Aqnl+f7qfEZmPxD+Z/X1dmbdtrvUYSSUEWwFcNbrM/w8BrdFx8a6giwnYH3avZ5o5MPiXBezX6O2jDUe7+9KySWQxmowQiWsxysCkRAr3kBJQTajPJRvDj7hYh9pZVLc8W6qCVZuYLmgLWWyrAmyIvhwxnOE8BdRsxaNqIwyhJvuUMLJXVvQfW0v2CAbAK+3U9xUzfMuNRMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(33656002)(52536014)(66946007)(64756008)(66556008)(8936002)(6506007)(7696005)(86362001)(9686003)(26005)(2906002)(71200400001)(122000001)(82960400001)(38100700002)(55016003)(186003)(83380400001)(38070700005)(110136005)(316002)(8676002)(66446008)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w/w3a79jLJyypX52QKO0kVsZkRjdRRNroccH8tVOr4Ctok/G6jEj/5Cvuesr?=
 =?us-ascii?Q?EeZCgfXY8gm/i/+vvF/bgsYJn8pe+Ku603OPqzcUivvw46lA4hWADbsnySSH?=
 =?us-ascii?Q?kGtpnCOmd0GCbiVaq2zzJIvFE8V3gYsgJxSMFtAWHCWK55LaziHIsfQgg2km?=
 =?us-ascii?Q?VktD25cUvlsU73oNfMIlbdXY7mh7eGbQf1JO/y9Oowf+UxKyMv90nzomucvm?=
 =?us-ascii?Q?9KASziGZRyC86k2T4APu2U7dnkwUsBlc4LnW23K471tTXEnwScDWmMisWMuA?=
 =?us-ascii?Q?SSCMZpwt1CKIQ4LKiNjzwZCpAiTVeePScmsbW3MRKHBqird1c5/mOyNOWlrv?=
 =?us-ascii?Q?zT9abpAhWPGVybcMbP3UNPkoglZrOTHQwp1lb/FPk9kuffAewYwAcXzNhOsa?=
 =?us-ascii?Q?ef1S5M1vdaH8Lbmbwv1V9bvTP9NCGQb/CTkv1AKcXEB+0AoKrkiunGY68PUo?=
 =?us-ascii?Q?vW2Ys+oP6mNUjz+x34AL5nsh57tehQ3tWU/OxM87K8SZu6oh/2Z/LpmGKtpa?=
 =?us-ascii?Q?ty8K8p3eIZdzxCVZf6J9kK1igRqMLRcBLjHaKueY8+aozc014aZZEHWKU3sS?=
 =?us-ascii?Q?va1fdat5LJRY8tY2izT3ersiUJIRe7Se+Vj+LlCTyzuIGxTP70KHpG5gP5U6?=
 =?us-ascii?Q?nujOOCUQ3Dd1hv2DEKcD5797e+YUbh8Wgwq/6n/JXGLRIup2N13NfZz3GeYP?=
 =?us-ascii?Q?vL7CGxqvyoGk4G7wyjG3+78hPgih2D5y/uDmLAEpEci1rk12Ja/nd0g6m1YJ?=
 =?us-ascii?Q?uw0jEeKDBTJZb5GJaaM0gmjgBRy9EVAhaYRsl8OvWtRJ0haV70i+7CblVjQg?=
 =?us-ascii?Q?v+WEgJjv477s7vFtllHPbxy69WOCy+a71cbzYiV/VXYvGPQJerA+XhXMIuFA?=
 =?us-ascii?Q?8QLFc7bwSR0DtydpdwSP0mHnHcne10ot0MP8p12TFbMeNUpM7u3DkjmlKM12?=
 =?us-ascii?Q?jcuxVumaq7Jcbjv+FCoFycKnz1TuwUEndaiVknSijTVc8iNKgdKOB7xVtUud?=
 =?us-ascii?Q?DQCXjHEmBnspNbUfaEq3WEhEIV9Y/NMhJOircUpr8rafseyh6m8N1MS5qB/i?=
 =?us-ascii?Q?kxfR7hShOF4mUGF+bu133VOeb/wJ6KbXl6Av/yfpeztFZAKGxUA/qXVSelbU?=
 =?us-ascii?Q?bkQkr/wgCWmhTAYxRmGT5h2761t2u1hx4qqYHcDgfhGjwuNbjUhPBg7yVZQj?=
 =?us-ascii?Q?WF/pMVuVeyK0C7FyknZUaOmNtRd0DxWcCS9uy8gacZW7vMCrB/NI/smZ08ve?=
 =?us-ascii?Q?a2tjfX3xg5XWMebHP/8v/cDV2I063pkQ9sEWWCag1spFUn3opqQpcw6H+kC0?=
 =?us-ascii?Q?FDk7Z1zdR7icVePDDjBuvkyXd2IgJFbSKAQY9Hi+ARM5QB50amIbzBxeH7Vy?=
 =?us-ascii?Q?8hImVGA3A/roR743N4vNHe78imwKCbs3wzectywgaUxomIqxhcuroe/5i1GA?=
 =?us-ascii?Q?Xncs+3ubpaVfx0fQiF2950VB3y8qYViGi/XyKEZ5PQuy0CFeFes9IW7RVyTw?=
 =?us-ascii?Q?x1OQpKCoVJ8PWx/nbyb6xqxN+ubZPVMSxrFaNsAovt70PPlo/l/FGj99u80c?=
 =?us-ascii?Q?oRR7uLFDAcqxQUC/wCJF3OU28kSc9dHA9uBOaDnNyxbIFOb0UyU0N8sgrsho?=
 =?us-ascii?Q?8m6DX7wNjA0c7vFs7r5RWFt7/P1tIj+3RQAolhFheYNGZjQljcvjYaLF7bp9?=
 =?us-ascii?Q?KEUk8ss7m3TZChLZFd4i+5ZjhVjsfNgVhiv23nzvVb/Bn+UBlTUvwICB8IxW?=
 =?us-ascii?Q?VJC7KTflbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a52823-9934-4c0a-18b1-08da41e50e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 02:35:26.5104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecV6P9XMKMQGTvh8tiG2uLItj7oOoiCD6QZaFsiSu349tYRY2VvUWgzQzfkmZf1qxrIIYF/aAf5iQ1HCX5MmMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4534
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3] fpga: dfl: fme: adding reserved bits for revision of =
FME/Port
> error
>=20
> From: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> There are 2 different register layouts for FME/Port error
> registers. The older PAC card like N3000 used the older
> register layout, but to improve the scalability, the new
> production like Intel PAC N6000 plans to deploy the new
> register format.
>=20
> To distinguish the register layouts, we provide another sysfs
> node for revision info, but it is a bad method that using one
> sysfs node's value to determine the usage of other sysfs node.
>=20
> This patch introduces 4 reserved bits (Bit[59:56]) in error
> register to store the revision value which readout from
> DFH_REVISION field in DFH register, the DFH_REVSION field also
> 4 bits width. DFL driver appends the FME/Port error
> revision info in those bits for attribution on the readout
> value.

My current feeling is that the essential requirement now, is
that userspace requires to know what the error types on the
current FPGA card, as FPGA logic can be customized by different
user. Ideally it should expose something like GUID to userspace,
but now there is no such design, if GUID design could be finalized
then we can just expose that info via GUID sysfs interface, if this
is not possible, then I feel even revision sysfs interface is better
than this kind of hack.

>=20
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
> v3:
>  - no code change, just add some explanation of two register layouts in g=
it
> message.
> v2:
>  - add documentation for this change.
>  - fix the reverse xmas tree declaration.
> ---
>  .../ABI/testing/sysfs-platform-dfl-fme        | 37 ++++++++++++-------
>  drivers/fpga/dfl-fme-error.c                  | 36 +++++++++++++++---
>  2 files changed, 54 insertions(+), 19 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index d6ab34e81b9b..b886568d6071 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -50,46 +50,57 @@ Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	Read-Write. Read this file for errors detected on pcie0 lin=
k.
> -		Write this file to clear errors logged in pcie0_errors. Write
> -		fails with -EINVAL if input parsing fails or input error code
> -		doesn't match.
> +		The readout value has embedded 4 bits revision attribution
> +		in Bit[59:56] which reserved by hardware. Write this file to
> +		clear errors logged in pcie0_errors. Clean Bit[59:56] before
> +		write this file. Write fails with -EINVAL if input parsing
> +		fails or input error code doesn't match.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie1_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	Read-Write. Read this file for errors detected on pcie1 lin=
k.
> -		Write this file to clear errors logged in pcie1_errors. Write
> -		fails with -EINVAL if input parsing fails or input error code
> -		doesn't match.
> +		The readout value has embedded 4 bits revision attribution
> +		in Bit[59:56] which reserved by hardware. Write this file to
> +		clear errors logged in pcie1_errors. Clean Bit[59:56] before
> +		write this file. Write fails with -EINVAL if input parsing fails
> +		or input error code doesn't match.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/nonfatal_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
> -Description:	Read-only. It returns non-fatal errors detected.
> +Description:	Read-only. It returns non-fatal errors detected. The readou=
t
> +		value has embedded 4 bits revision attribution in Bit[59:56]
> +		which reserved by hardware.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/catfatal_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	Read-only. It returns catastrophic and fatal errors detecte=
d.
> +		The readout value has embedded 4 bits revision attribution in
> +		Bit[59:56] which reserved by hardware.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/inject_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
> -Description:	Read-Write. Read this file to check errors injected. Write =
this
> -		file to inject errors for testing purpose. Write fails with
> -		-EINVAL if input parsing fails or input inject error code isn't
> -		supported.
> +Description:	Read-Write. Read this file to check errors injected. The re=
adout
> +		value has embedded 4 bits revision attribution which reserved
> by
> +		hardware. Write this file to inject errors for testing purpose.
> +		Clean Bit[59:56] before write this file. Write fails with -EINVAL
> +		if input parsing fails or input inject error code isn't supported.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
> -Description:	Read-Write. Read this file to get errors detected on FME.
> -		Write this file to clear errors logged in fme_errors. Write
> +Description:	Read-Write. Read this file to get errors detected on FME. T=
he
> +		readout value has embedded 4 bits revision attribution which
> +		reserved by hardware. Write this file to clear errors logged
> +		in fme_errors. Clean Bit[59:56] before write this file. Write
>  		fials with -EINVAL if input parsing fails or input error code
>  		doesn't match.
>=20
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index 51c2892ec06d..a440bc09938d 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -39,6 +39,22 @@
>=20
>  #define ERROR_MASK		GENMASK_ULL(63, 0)
>=20
> +/* Bit[59:56] was reserved by software for error revision */
> +#define ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
> +
> +static u64 set_error_revision(struct device *dev, u64 value)
> +{
> +	void __iomem *base;
> +	u64 revision;
> +	u64 dfh;
> +
> +	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	dfh =3D readq(base);
> +	revision =3D FIELD_GET(DFH_REVISION, dfh);
> +
> +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision);
> +}
> +
>  static ssize_t pcie0_errors_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> @@ -52,7 +68,8 @@ static ssize_t pcie0_errors_show(struct device *dev,
>  	value =3D readq(base + PCIE0_ERROR);
>  	mutex_unlock(&pdata->lock);
>=20
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>=20
>  static ssize_t pcie0_errors_store(struct device *dev,
> @@ -97,7 +114,8 @@ static ssize_t pcie1_errors_show(struct device *dev,
>  	value =3D readq(base + PCIE1_ERROR);
>  	mutex_unlock(&pdata->lock);
>=20
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>=20
>  static ssize_t pcie1_errors_store(struct device *dev,
> @@ -133,11 +151,13 @@ static ssize_t nonfatal_errors_show(struct device
> *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	void __iomem *base;
> +	u64 value;
>=20
>  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	value =3D readq(base + RAS_NONFAT_ERROR);
>=20
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  static DEVICE_ATTR_RO(nonfatal_errors);
>=20
> @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct device *=
dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	void __iomem *base;
> +	u64 value;
>=20
>  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	value =3D readq(base + RAS_CATFAT_ERROR);
>=20
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  static DEVICE_ATTR_RO(catfatal_errors);
>=20
> @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device *dev=
,
>  	mutex_lock(&pdata->lock);
>  	v =3D readq(base + RAS_ERROR_INJECT);
>  	mutex_unlock(&pdata->lock);
> +	v =3D FIELD_GET(INJECT_ERROR_MASK, v);
>=20
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> +		       (unsigned long long)set_error_revision(dev, v));
>  }
>=20
>  static ssize_t inject_errors_store(struct device *dev,
> @@ -211,7 +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
>  	value =3D readq(base + FME_ERROR);
>  	mutex_unlock(&pdata->lock);
>=20
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>=20
>  static ssize_t fme_errors_store(struct device *dev,
> --
> 2.26.2

