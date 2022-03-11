Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6342E4D5978
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Mar 2022 05:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiCKESG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Mar 2022 23:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346049AbiCKESF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Mar 2022 23:18:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE271A128D;
        Thu, 10 Mar 2022 20:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646972222; x=1678508222;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hqoEzziR+cR6mVlwLzk7zMYKGF+NuAalJHKBvuc3Bxk=;
  b=frcQa/gLSg81XgSG8yYLvQ7XgRNLCVs/zo55k0oLMq9pSbG2/rhTOzGq
   AOhdMxaXX4crNYwRrmeJeBR4im1B/xx104iarTuTY17NxWjGqlh56enC8
   Xfzkbg87q3x/XZ3vHQs5aL82GBa9ePSXhClT6C4HbMXShwHNgt4GXSOOu
   tNZNZaC/80Jxgcs3COfjvMVlXVH2OULpZx5HKURFxEO+ZYmHUQY6pkapr
   ShZursDp9Lr1/6+j/JhUhKZmUyFpAY89cvRRUV2Ait+wULNU6I/v0rNN3
   6njCd0WsQn6PF7Ug/ZxGtJX+571fwVdAkbJAehwcqENqLUU2sNVTnyueE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341924232"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="341924232"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 20:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="514363579"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2022 20:17:00 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 20:16:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 20:16:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 20:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBRcmBupFtDslGGI5dBnI+2fdj1WG+Tmax2JojIR6gBMYVdDQFCjV6zEIcJIZNK0Sk4HFyzJ8Y/XdmUSirNFKU8qdqIEhWChdPGU1euNWoy5ja2DqV1EZjTsNX1zkMGCI82VduGh/dJMM8R9uWA4LDgUACzM33qHvF861Mx1BK4Ze1TqnUt/HZM/GCUUjLOvqjiKOZvMaUBiHj5eBmvAJWN78CTp9ExOG/bEfEBJw7Bc5S+b1+zDaPSLFRkVPocKI1gjYID6Mlaq7vZsr2S+qcjw4RlgQAkwnXZLP4sw3HuFQ4X4wD7yG8OPb8ULCiUxjDilWxVPY/MIHuVnVekTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40zrQ5mm8ghkolfjnpBq6vH7m6AdvBZU+mwe0/M5FSU=;
 b=BT60o5jaFSNkGpbU1C/co+ZzEE++FYBcol/MuxJQ2S5VLbg8R0LOxChos1sxUkzG/78dNdJpxJbWREu4+kD5kBoaBZ3W/f32VVITN46nlBnzw30L1JehXyYpUJThTaB8huv9S/rjB/mFsM977J0OqSJ/Fk6ZhP0ovEj1e0VG4b3Ht5qAjkHT/eN5R7b1Ky4so4Gcd3Q7UOidDB3cg+s7Gffvz55NQW/pEg4y5Tp2vbNbi8fDeH2cU+KuabkFGjtdA4FwyEbGEadX0RyE0jxMIqbiwKcvrmnlrGdwwwiVVE7LuJqQ+RbpTlaU1Y8AkWkOan0a6bb5yQ89jaqWM48ZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CY4PR11MB1559.namprd11.prod.outlook.com (2603:10b6:910:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Fri, 11 Mar
 2022 04:16:51 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 04:16:51 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Muddebihal, Basheer Ahmed" <basheer.ahmed.muddebihal@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
Subject: RE: [PATCH v2 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
Thread-Topic: [PATCH v2 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
Thread-Index: AQHYLpZT7Z7itnhgnUS70d9Sjf19Wqy5mIFQ
Date:   Fri, 11 Mar 2022 04:16:51 +0000
Message-ID: <DM6PR11MB3819DB0E648AB7A2B85E1FD9850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
 <20220303003534.3307971-2-matthew.gerlach@linux.intel.com>
In-Reply-To: <20220303003534.3307971-2-matthew.gerlach@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: b291fca9-eba2-415b-7783-08da0315f7c8
x-ms-traffictypediagnostic: CY4PR11MB1559:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CY4PR11MB15591198D2C5D842DD33150E850C9@CY4PR11MB1559.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaeYRLPJirCkqJPtL+iVcjKxtkQfbqUdMnvDiu7HfjFtdxQFiCFo4moPFLUKTfSXXEtJWvLAeHBE5Q8gDQlgWmE5ldaERmw1mpaKxn2HSsk5EVGTvAZYxV4K0p6YPHJDElR975awO9ZV7OXwkLpUBeReHwCLABNmKhtYD4g7XlOYM9EJfVbSHhEDiQcsPWizuzCN6a1IaoC2ivnrTlP1vqLkDwnyGHk1VFdrp+tlYKttseIHhiNgCkXVK4TrezdTA/WdRMHub5oZK6sQvplENDWGonRdcxcVCgGiLg4Rjf84V5zoJsbkSn87iWZAduC+z64UGTOpenONPoWJIM6PeuY03W4q3YF/rE0GhJkZQPxmr3+4bfTcGPzhK8ohYVz5KXbIq5x5etPggbstMde5oKx9TUbLfGIYQ9En+t8SRaIRoLxwVdV1i/WyAWQF93rIwddLpGPnICWizaGH7J+gQHCakwHK85shjLPm8RIlEyKDKc3+wj9d2DFo+FM7lTe18M3UM2QN/2Tnu749pTc9peTO7oYd0GMfluvDVbg2M0bQykCfTusESNBeopgM1/b1miiHWQPTcgMaxlrslTq/C5Q0/qZAiwqZYrbrEJmPy0n1askmVnoFwsVZDfebIOG+cOWmpwJc3M3fS7B1ZI/6AFZLR3BFVx3ohmUW0UeH/uaCuL+GK23Os6woDEPgbUV/O/PfRA25GKvA42Y7qd9j6tyblOKRRtMteNkXIU6zKko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(9686003)(38100700002)(921005)(7696005)(316002)(110136005)(8936002)(38070700005)(71200400001)(6636002)(5660300002)(8676002)(66556008)(55016003)(66476007)(66446008)(64756008)(66946007)(508600001)(76116006)(82960400001)(6506007)(33656002)(52536014)(86362001)(186003)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MrtXHH6UMM6QWMb4qXxPZkJ0XnGPPcerU7uO7C310+WHjVYg/yWxZLTsRdhG?=
 =?us-ascii?Q?bfTuKSfRYDRKJLl6GUXrANu2nMcTqcfsz82rWoQ9It77Rl+3pSu/9OEyyDN+?=
 =?us-ascii?Q?hN8y12si5SDUjGOz8Jelng/IKzvayYwei6PXLUxVTIA+MVjKEC3Z6LW0ke4V?=
 =?us-ascii?Q?m5Mi91Jmrk/ee0Oitie8EkkTPeNBzX1aUNKOmTPamySKC0MTYx2AEu28N2QH?=
 =?us-ascii?Q?OymYH8/ufYqlv5tIcVSzIpwNlbtFmQpQuv2hqhJjnf6IcxYc2iZY+RMJdPoL?=
 =?us-ascii?Q?OS1IRmEHVmgEaF3A34/Oh9eZQfusDchKREpo2YKlinuPeAwfiTidFykHRdhk?=
 =?us-ascii?Q?4CX1UiqS3YFmbn6PfNKV0+cGhvBTJLSXakERYnjVeZyuid03O74tq4yoA836?=
 =?us-ascii?Q?+lfWi5OiLdm/TJOB0GJxDYTnhHc5AsmOff8mhpvfBVSe9uEyVRnFDXI/wOGP?=
 =?us-ascii?Q?qzYZFMruL9GyU8BcQ/62Ov0DWAysT+dPu7ZyGaN34bfir96I3z9GBUhBZdxW?=
 =?us-ascii?Q?wA1JOGMZtUb5cxmR/isoK7xtu0C+UsomqHiFrwAsuRjRj3H56klec9vfIq4b?=
 =?us-ascii?Q?OvIyvtSXxh4DqjmJ2JKMCB8VIwiidLdyWajBGCBx7I/G3J2w8yceHMTjPyKY?=
 =?us-ascii?Q?mb7VI3Vc9INYBbdIK8YUcSkyR9AZQOTPHRHunGouTKfIM+VqowRtGXSfwyp5?=
 =?us-ascii?Q?wT91tdgVsCKNaYEIvvisWYkA8pNclK5x8rbBY3XMNtjlEJCX1b9jG5vVmO01?=
 =?us-ascii?Q?PHNNPiCpG65q/CGnDAAfVdWRyENzVWf0Jt/h16Ke0KotKgJoG/DtFla5y0iv?=
 =?us-ascii?Q?JqgPZHfEJFNQ3u7PwNpUGBLs5p1yhkARW6sZAtHOgrm3RK6k+kkE47YZ+B90?=
 =?us-ascii?Q?poXhzhSbsbHWi6lmhhQtGPaon3ctVGDBhg4lmffbj2ltF6b9fRDZVw9KnbWR?=
 =?us-ascii?Q?Cazunzq3lxVXdAfl0R//8Ni63Yc92of5nAv9131xlIWHp4rJGGUenCFmohAq?=
 =?us-ascii?Q?50kTv6Qz66n8ZfD3OKRLHkTDWOIWvKu6VQI4aPe4GJsVbsL+5gwvxZktGOFi?=
 =?us-ascii?Q?7BPg03SD++FiR1kfqpXcYoz0PxUFTpd3YZKz4ijPTvSS7g6WLeoJo++5n2zP?=
 =?us-ascii?Q?aWjpcF7ubRnRVLOOGzQnyzpNSsMCCTXAiPLTSrk1rrYLRT0H/nGQTvwERpVP?=
 =?us-ascii?Q?cEppKPig7QMdF3U6K2d/noijrytptxOPTo97qz2/Yth4AFI8SHcL5UQi1W4f?=
 =?us-ascii?Q?s5fpu5fY5H/z83boX9mbFkvQ6zKukPpqs+P734pMZbQ3rajKrY8WzolGIol2?=
 =?us-ascii?Q?FO83ny3IkPFeqezEvKfiy0eGlxTTwsDNBAPFPhnrDKIlr9RIn5lM/NNKfjYt?=
 =?us-ascii?Q?/4qeh+Qi/W61wPdCaLah1UdQ5slGRAvcJAaL8Yfw8UjKCTYN63MCIXRP5xaM?=
 =?us-ascii?Q?6OBh0wJK2jb9Tk3hLGKBhVKOYc2NZQH6oUmOL5zttSBPPLpJl9aLA3/wzEhS?=
 =?us-ascii?Q?C2FMHXe3Qp2LTSc8N/7/3YGBTnzbDIyBBwCU9wh/Y3OmL/BEiqDWciKUWCC8?=
 =?us-ascii?Q?SpQ7sSUUBrUPjlw8UNL9JYvAE1whD6QfNqLUyKeuX/E+Lk7CyIwtvCrGFmvf?=
 =?us-ascii?Q?NrKdv53sSsu0bRdedc25DHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b291fca9-eba2-415b-7783-08da0315f7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 04:16:51.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyIqWJDxAcCVQ25B343FyeiNYomPcahdv2wdDpKF4GWdjdqIJc0f9/zYP/L5i4f/TK/BgSp6H3CiixDmWYk65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v2 1/2] Documentation: fpga: dfl: add PCI Identification
> documentation
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Add documentation on identifying FPGA based PCI cards prompted
> by discussion on the linux-fpga@vger.kernel.org mailing list.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: Introduced in v2.
> ---
>  Documentation/fpga/dfl.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..5fb2ca8e76d7 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,6 +502,26 @@ Developer only needs to provide a sub feature driver
> with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme=
-pr.c)
>  could be a reference.
>=20
> +PCI Device Identification
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Since FPGA based PCI cards can be reconfigured to a perform a completely
> +new function at runtime, properly identifying such cards and binding the
> +correct driver can be challenging. In many use cases, deployed FPGA base=
d
> +PCI cards are essentially static and the PCI Product ID and Vendor ID pa=
ir
> +is sufficient to identify the card.  The DFL framework helps with the
> +dynamic case of deployed FPGA cards changing at run time by providing
> +more detailed information about card discoverable at runtime.
> +
> +At one level, the DFL on a PCI card describes the function of the card.
> +However, the same DFL could be instantiated on different physical cards.
> +Conversely, different DFLs could be instantiated on the same physical ca=
rd.
> +Practical management of a cloud containing a heterogeneous set of such c=
ards
> +requires a PCI level of card identification. While the PCI Product ID an=
d
> +Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
> +that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
> +Vendor ID values. PCI Vital Product Data (VPD) can also be used for
> +more granular information about the board.

I think PCI Device/Card Identification is out of scope of DFL. DFL is anoth=
er
level concept, it can't help to identify which card it is. There is no addi=
tional
requirement to users, they can choose any method they want, and they=20
don't have to reuse dfl-pci for their own cards.

> +
>  Location of DFLs on a PCI Device
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  The original method for finding a DFL on a PCI device assumed the start =
of the
> --
> 2.25.1

