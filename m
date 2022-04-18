Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B2504A81
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiDRBfB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiDRBfA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:35:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE817E36;
        Sun, 17 Apr 2022 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650245543; x=1681781543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ybk0dpvTT4TnlI0NinZ4UUDQNb2DT9cdU6jDrUIKVZ0=;
  b=ay+WOiccZyMFOcmqqrd/7jdZtl+GzsDq9odmeXJ4ZSI3huspTWOW0zW1
   py8aRzlxRBLqLGr2ptXrIj9iQevCZFFQz3TlUrPQtsXvztpQZiBQ5TMP7
   SuEtUcU9nWdvwg77xnl3on2IJyCL0pHomClPTv/hVtBw2rwPWhAYKZQO4
   YbdxIM7bHYnO1a7LXzRjpdF9ke4Uk20SI9fcJGHkt7xi6wYqM9k8MOe/L
   GddSzrkbk5qf1DfT7R58o7uqZ7zr0roFZCOjrT0nttfr5Mv9ERFm9K7Y2
   7cSHE0yKVccXzn4Qhe8+Hxs48oYBfZbt9xrauuuTzhO/gg6tSnoF5eAaY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="326333032"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="326333032"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="804130728"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2022 18:32:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:32:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:32:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:32:21 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQZucCxGG5iRJxs3gWHOAdwu29p5/cFgxmVT1R8gz7Jb9QTUBcEsUowVviYy3+6z6xNEM9bMYB/I4XW6VRmGmr0Gswsc6Uz8DRINGiox6Zzh2BiRtF7MgSlTi380ml3oE3y2UgDfn4ce1RQsCC0OB/OQ80J93iT+zvSnpUZd8xoHtILwkNXxKnHj3wUMwyQIQHi6LoX9dduCoxQJqud9hHyB1r0+MhmzL1VYttlUff6zQtGf8HlAheOIqcT9HjIA2uIeKMnkJ7uzAYGtfUy89NGsZqlDBg7AALXuxDFHrXlz6dQ/Ac3MtOd1OHGMjFldMrH5k9eJfIcNHUZyrLkaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12l771/7qD1A4LDpzUT4WHWAcR6Llc/ut+RQMj529IU=;
 b=Ob8BLFsUbuLi1KMHuJL4wLmYd6jfKDqClu8GtV0Ns+aWa2crMs19K9H+J/0JBG2N88+42ZoObqTb8jrBqtMA4ppQPPdnhfHlkN1W4TNWar2o8diWLONaG6UEhUCTRMt5bRYdBFW/CH+IbmKHPPRbmsoD9il0+SFRB2toi2AFC1aM5eiyE3T0xXzlMJ+8pmhKpnIBH1TIye/8u+645zTTXWij5CV/9WdSmdfXdU31eTbEj0ITyk26Sx4k8BpCnNpOPfI1RPPTqApxjvKh+lfYC6wifYOGBEAWcEWqY18j9jLqzNHl8InehN+7ZjGAGY/y5VpLoRVJ46ZR5wdzOC07fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 01:32:18 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:32:18 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Gerlach" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Index: AQHYTjZdBoHDFBYOuES9CQIlYPGclaz06tqw
Date:   Mon, 18 Apr 2022 01:32:18 +0000
Message-ID: <DM6PR11MB38190E6EEF6DE3EB900290C585F39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220412062353.53984-1-tianfei.zhang@intel.com>
In-Reply-To: <20220412062353.53984-1-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: afce7410-e8a0-4aa6-3543-08da20db46bd
x-ms-traffictypediagnostic: CO6PR11MB5587:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO6PR11MB5587B7BB72693BA3E3EAA5D685F39@CO6PR11MB5587.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZul/iT6ec5ZGQywSge/GKASdI5DcB0Ol4i1XvFjwMTygmGQkcxa0YSbCGS3XpKMRB1GdwjaWGbfYyIDiiewHYvmLAKBN3DMBJjh/EnZwg7cDAr9RPMWbpSWuc8MQ44BxeRiBU011xa/U+/5NjnZa+VxX67zam0hib4/0jgfU3Lsx61OoLQBm051kubHAey+LEiGOdlSJ2YRroXUxVPuIOeGgYbZ6wQwVyfFnv/xSxUarqs4Y7WmSccqJ27DkrZCfgbGOtKrsBzBCYZ7a9FI6XJ5IjQzzR1SRgijf8mqzLv/q4omRFSStfhtuITVmsAE03AurAI3hnVY/fxcw4GZbNSrAizwo8DYS6MroMlU+ZVCic9Cu/y1zzH0/AzasAaW7/sNJuEzHs+ItIjGsFn5rsNWrcffsQvVzFAUz+6qYpTftzFvJarWgcZ0GKB91ACuhLhuQ+LTDpQs2dxZyeLoRYFOXwonrGLhEAqfWn8mMteOtwDy8vPwScuDfFuDrSYxwJtMvvcqt8ASAlg5tmTkQB0avMNppNghYbkRR/VgTcYuTm9kBm3Sz23bo9LzEW4zWZMqTZokY9fJYlC3STadS4PCqjxx75vquRSqfT1KYVbIyxUP/RNzytoHzFbM+4U4qxM5elddeM3J1BKKnMiSg1PrTO6m7DYTkdtQONOnQMDm8Zb1BsfI8Rvk1GPBmNRVUpI6jB3VxYSwwHWoMD0Qx49iFS6HhtsSWTz3L6HRdQc3hlWV6Hct6Dyqcet7XBILQdJLle9I9/TcYPDVTy7imXlaaMt88+/tX2twHA54MAiUlgd42N2ooKPkeD+Ev9lu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(26005)(54906003)(316002)(86362001)(9686003)(6506007)(8936002)(186003)(71200400001)(33656002)(7696005)(82960400001)(966005)(38100700002)(52536014)(110136005)(2906002)(8676002)(66556008)(66446008)(66476007)(64756008)(53546011)(55016003)(38070700005)(66946007)(76116006)(122000001)(4326008)(5660300002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1+ugBTf3zbKQLZItNsyD6E21CsTNlYOAKfu2OXKaxWvtYalVXAjRBS+ea45s?=
 =?us-ascii?Q?j9b+x9M4p0wqXc5dURilBkEQfYfVOSWsNmAtwS3aJ8w2daslKE1vrNr6SP0B?=
 =?us-ascii?Q?TnZu8Vvag4PtGJEIscca14T6i7dKYIjhk4vCoCvE9gVlt+haDFaEanDvgkwI?=
 =?us-ascii?Q?xIoej2XH4Zn9sAAmVZ52ZtG2RNj88q2NZBRXFFTFWjPJ0IEUZYlVVNN3TQID?=
 =?us-ascii?Q?KZOh8865bT1wuJUbCRgH26vqrvKtSiLVnCOVPL87N9X9aa3Wwf/8sYUB/QbM?=
 =?us-ascii?Q?6nUHRow4c/vZ6aLPWsAvoMg2FEDW/PLQUkeMZqVUYcwEYLI3/pYdMR1666b3?=
 =?us-ascii?Q?iUzmnZXiKBtGFWKENQ9A3/P2yj1u7npXNb3j77qd00TTtmed6uTe81wRsTaV?=
 =?us-ascii?Q?NDLYcoZTwuohzC1ZORKlTN0Es/nXHd6rK58o1kelYGM2e4m6Qk1K96dC35e6?=
 =?us-ascii?Q?p6/gIgPTJE34mAxiTrHsl+TGG4gnwM68HozGkSAXgkrumujhxHtPFj2CTwgD?=
 =?us-ascii?Q?nY6gWsYLgAk6hxbNP9YB9TW/00LxxIl/LA4NIFVoezTz27UQ1CrbJj47uPb7?=
 =?us-ascii?Q?7dlyb6omzSDv6PvXNPKBXz8b6NMRRGTgr7Ar9mkAlecqjvC6mF8PSynxGPcQ?=
 =?us-ascii?Q?hwhgoihBTOVd/Kvqo2qaO7x8z6A5gl8gHKJFwZJ9YvJmhuEb2FICix2URbkX?=
 =?us-ascii?Q?bK7JQxEJ9tPMGsVuwUYu6ZmuRPpQl+YL+apf/ycH0Zo8yR/zp4OQeHIfKOKH?=
 =?us-ascii?Q?RElUjcH/B5QMJa9TrM3XcZezYsXYrabiqQ9MuNCJ1DKC47fMt7J91IGJmlmN?=
 =?us-ascii?Q?CIuplY8gOKLu7vB4jLgsvTbfjfZmy4BIsclYsnfTSd/n5/Ydpn6lnQS4FsUB?=
 =?us-ascii?Q?AJsxhmCKkK1yWjRl7T12bF+EXcT2toHYjcrMTFfs4dvPl2J4+0HUVbp59EdD?=
 =?us-ascii?Q?N05LvgUHeUSFl1HvVPBR9zkL3aNwfroSwqvCbDzBLEbQFYsyVS712pO++3xo?=
 =?us-ascii?Q?VBS2NHNgY/R5ISZGrnD1xLCbJE1WwYpn/VlivRF+HXzPZJVTTioVlB0D4Mqa?=
 =?us-ascii?Q?oq8pHABd5u0K5Wt2BNiMMOIOQpKpsjCW78IEyUHb6vKLy3u5347lOF5lsj99?=
 =?us-ascii?Q?nGykvPNfepos3sCToIafuqgfRTHB6ksXvoglSrrXL/ZsExn1BJZB1NVXeRSM?=
 =?us-ascii?Q?gEX8cJ17Glv58pR7NFsEOAFh7+nGuWivxEelQDEXTWpxZHNJ+kVzITeAcijh?=
 =?us-ascii?Q?QZZBRs3IpG1ATbYzm2bj5lJLGgl8K3YoQ0ArOFG8LaI9hqdKkfJAdud/PuZi?=
 =?us-ascii?Q?6nkp+OVEFbT3m014gOLWKc1Rhm68AMgjJJNQZFym2RGKiaYCZIpaVx8qqm4N?=
 =?us-ascii?Q?/oMBXqFLOZMsH/KYGJEaBHwqxXpwaj4tvKEYIoCcIBBqGEcvh6tqh7uIEH/3?=
 =?us-ascii?Q?uhYcP0tPRT1vYpKMongm3BCswEnmlw/+Dv3IYoz+OLPRwzMSVFkW3ySr7K/W?=
 =?us-ascii?Q?jVgSVLPmnMj6TWt1t54ABhi7gt3YTUFYqw82b3yMuGYmZvCjEXpiSnYwDKFK?=
 =?us-ascii?Q?qcaLzrqI6gVqSxz8G6pyqzMq7wPvKj6aaTTjIn1fyCU9QQhsNyVxRc15U4nL?=
 =?us-ascii?Q?8zkf4sBluHrrRNcuL6ZV1a/+baiYxx8bpRtug36DnrXt6Xwjh/2VfU4IUIo5?=
 =?us-ascii?Q?4LrKugeC9c5ly3bkKkT40DoNWy5ZYwchmWwKWfN5+j56NC+Ey+kTryW5VxdS?=
 =?us-ascii?Q?QwvVMia0vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afce7410-e8a0-4aa6-3543-08da20db46bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:32:18.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skYx2KXpDeNstrPgBFnKmGgKyBFE1KMOhBiHEcNAYo5xrWwY9ZaGZxFDykmDxtkFFs6ETqL93mp+okVys3cGmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5587
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
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Tuesday, April 12, 2022 2:24 PM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> gregkh@linuxfoundation.org
> Cc: linux-kernel@vger.kernel.org; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Zhang, Tianfei <tianfei.zhang@intel.co=
m>
> Subject: [PATCH v2] uio: dfl: add HSSI feature id
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Add the feature id of the OFS HSSI (High Speed Serial Interface)

We still don't see any description on what OFS is here, or will OFS be adde=
d to
title as well? we don't expect another submission with the same title but f=
or
XXX HSSI again.

> subsystem to table of ids supported by the uio_dfl driver. HSSI
> subsystem consists of harden/soft Ethernet MAC to support various
> ethernet usages and PCS/FEC/PMA direct modes for non-ethernet usages.
>=20
> We leverage the uio_dfl driver to access the HSSI subsystem on user space=
,
> because the HSSI subsystem was designed for specific purposes and does
> not fit into the standard MAC and net kernel subsystems.
>=20
> The Feature ID table of DFL can be found:
> https://github.com/OPAE/dfl-feature-id

Why you put it here? even this link there is no more descriptions to unders=
tand
what it is. Or can be removed here.

>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v2: add HSSI introduction and the git repo of Feature ID table.
> ---
>  drivers/uio/uio_dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 89c0fc7b0cbc..660e1d0bf6b9 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>  }
>=20
>  #define FME_FEATURE_ID_ETH_GROUP	0x10
> +#define FME_FEATURE_ID_OFS_HSSI		0x15
>=20
>  static const struct dfl_device_id uio_dfl_ids[] =3D {
>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> --
> 2.26.2

