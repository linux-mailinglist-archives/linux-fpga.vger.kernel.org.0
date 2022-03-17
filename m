Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C314DBD3E
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 03:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiCQCvw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 22:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiCQCvv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 22:51:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2431205F6;
        Wed, 16 Mar 2022 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647485435; x=1679021435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yrCKNch9pvQtA495w+XMZ/xp2BYXZKt8m19piGIekkg=;
  b=QqtU1o9FN0vi+hlfy2a115NgaoFG2Y7NB4pNUegiQV2aIkkg9aldYtas
   BsIEUNLuenGRU5QPDZXXTFKyOj4y9XmFgraFLyL3FnD5zF/AY6V3Csy+i
   FR/fei/jRHEibSH0GXNmM4Av+W60qAyvcHwyfS3ol5Z9yYeiuBr2qEtbZ
   D6yKyF6RKGb0QXfN0hmCO6476uoWaUfCa0mRXfald5gJ+ysaTBB9CEHd2
   IPhcHzlaH9/wY1t+oDkrPI9RI/VQOvyjYhFl1CPwsJhVFpOBcV3BGGPmA
   4CCBNW3r13Dl2D9M7ryTqdXy2WMwLlWiOCQSJrtTG5zeWzgpwyOPyGsUy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236712177"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236712177"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 19:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="646891781"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 19:50:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 19:50:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 19:50:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 19:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoPu074mAgUE4y8s+a3nX43vCno5flUBS7UgadcBt55cg7Izl91PnMWd5eGLLz+Nx/7I85L8UQx/1xbsh67N+IcpPj3xszY1pUWbAd1NzJ7BMWdg4QJ+RR6QjWHOk01MYHJCef1ECxte8/11RyxYFWnJX9YBll+/ChPafH/bGf+y9Xom9GlWS5c3viCaFvSK7ox/3SG4N9vUAF5EaE3N4Sb+x/w9aiwp1CBghg/q45/um6+WayYEmNiZVSqlQfI3GN+D6pb/gb+QmlxRZiKHlCilY0NvtcsHqSgfI/7ba17N0vqe/wmeGwZYwoKbVsMozrkx7Zc5HsUx5s3ji4c9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVKqQQc2SioY2o/x+ngkN0T8iMZNPdEJZYtms1KdgVg=;
 b=mK8l8+berNDVyKWRM7arnbNg6zbtCnSP3j02hOBky/6KUdUUkaKRs9JJLuiGPGfiy4cYFNFXnD+ZjhPN6z72Jei2UHi5p4bIMUET6bUeaFSIa29P0klbyvlU3czOqmoXNjysBL+XkJ+1m9fGKj7O0EotERE5vK3ZP3Js4kTxVlls+jYWUIudViVzwNIV+aUOyCITxeXpGkwtNs1U66M0cG64h1cFGRw1adgnMRZMa/ruL7JZe3QGi7n2+6Is+30BMArKxxkILTLgcafZy+4Np49DaF8obGMgWz3qQ+U/upP35SzjeigdqaCs2Q1/X9fDMvre/bxDBuH2pSkmlTFC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB2583.namprd11.prod.outlook.com (2603:10b6:a02:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 02:50:29 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 02:50:29 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3] fpga: dfl: check feature type before parse irq info
Thread-Topic: [PATCH v3] fpga: dfl: check feature type before parse irq info
Thread-Index: AQHYNO3Mz7yyGRAOxUOWMPv4ER/dsqzC2COAgAAQnVA=
Date:   Thu, 17 Mar 2022 02:50:28 +0000
Message-ID: <BN9PR11MB5483AD216BC179029E279E0BE3129@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220311021121.1504442-1-tianfei.zhang@intel.com>
 <BYAPR11MB3816A2AD9C59AC3A1B6494C485129@BYAPR11MB3816.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3816A2AD9C59AC3A1B6494C485129@BYAPR11MB3816.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 9e70ca9e-1dbb-4c06-473b-08da07c0e564
x-ms-traffictypediagnostic: BYAPR11MB2583:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB25835C7C67C2EFCE02489614E3129@BYAPR11MB2583.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7s0YywHLf8fJyBGk9+NHZQmFqHOmakqhftNR5U+hYnq6xTTugGlySjhvI4OSzXa9/1lmTovElyMdu604gwdflLYLhWiOHA3IsTHf/46EbylcYQ9IUKT0KlAOYgMRygvnrZWEWS9CS+UAWo+n5Hds+ZYfYdiRvrU4lUyYA15ZAOlvDn9FO0KC8Ks3BfkwJFh+mE8QTQeyrlkmwD94DidWhvGVWXXwqWeVbWHz+kL52lPMbrt0chpME2VlCBPoxQro63P/dMOlwupumiO8sWT8OVt9NJRD8YHmtSOsKVqdCIb1w4iPbBIFNLJwJ5z2r2GjYAh6uuCkTQDFe8sCtkjKw3NjV4vV0R7OxlhevXJpVHJ/z5EFgbH2iHa0HqWCU/QUBwAaLRrIsQxTGBIjTop48LJoAlMJbhKcdA8gYexnf8h5M49Z0GXyfPi11S+DsivF6VI1iSmVzdfoPelo/6k+Dp60kh21m8uWsfNUwXJWspmk45W4JSzPYW509vrEIVcORGcxzRRnBhrNeKqPqsfroruxsRWJddSsImNgyHEWlikOHRhKTwWG1N8ys+36iQGagsjz362uVQyJGe6vO45itq02csIAyg1PN53eFaPgdSLMwDvBdSqNpReFsCExOQyYcgotOv5yNfUytSUbrPobzcbZJpBotSSMwbPIECTxVJ+9AZx5hw2RIXuqvEtDFvYbpX9DHXIVU2YDDMQdlHvW8Yf0Lw4KJMjhBnqTlCDXbU86tOJiKOSLJllmyHOlFYXgZQM61LGBKTIuPIcSw0+3K1OZqpGLWbNVQVvwmYsZR6zCexPmEGSKu8G3abXw6jpB45IB129rGAR63L/4R/S66A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(5660300002)(38070700005)(82960400001)(83380400001)(186003)(2906002)(26005)(53546011)(6506007)(4326008)(9686003)(110136005)(7696005)(316002)(86362001)(71200400001)(508600001)(122000001)(966005)(64756008)(8676002)(66476007)(66446008)(76116006)(66946007)(38100700002)(55016003)(33656002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v6t0fegptKE2L2iv9YZKklFK+EeU2ngyM5v7sdNMm/mYgDFeMIWzLq7NsLTz?=
 =?us-ascii?Q?hWC/HNvW06WHc2ODoRJUmFy7LIYLNV3IvARHP9mgAh63/+J2RO7v4PU2kReA?=
 =?us-ascii?Q?uRfx6NWn1Acus02QTpBPzneu8eGz5XDivNlXCHo/ZlhP8yJzoK2WVXjx9xrC?=
 =?us-ascii?Q?gV/LzoKAILy/G1Pr9ZjaKU1RTg3yzd5i0u47hb0Ue5f5v7IQJzkzg1jDaOto?=
 =?us-ascii?Q?G6B5aTwF5F1Pcdl8nPo0Y34soS5vJDtj1G+YyY1NfdKRybdtfL+sm01CUFBS?=
 =?us-ascii?Q?liNK2mg+ppUa6X5eTM8i2y5kwEJhZ02HwzETq1/dklT2Ls7RUs+cjqS+Xrug?=
 =?us-ascii?Q?Aze4e+qrIvO4AZmaasPpvxxqq+akISPkLVyhP2vMGES94rGHZalNer3kChRO?=
 =?us-ascii?Q?5w94idu2dThwlAoOgKrhXljEroWyvKEE97LAp+U31vvsup9peMAftuJRrh60?=
 =?us-ascii?Q?7nZsK0GN71g2zD5quk6/65DUimUqsTfG+iKXbX6PBevFKiu8/4/FIYbgq7z8?=
 =?us-ascii?Q?XcWk7KZSpu/UOhYhUniYTUQUeu/3H+EI+Af/+0/tE9f29tqde8DRCKvaeT6S?=
 =?us-ascii?Q?Oy8pZt5aYchnc5RVWg/FnKXyWSKzQ1zZtL/1XHGTCc8gtKyjPIgaOFkpIpmc?=
 =?us-ascii?Q?bBhaagN31XqhCdwxc2QeqNZ6s/HRqFooPgPl4GH4FJ4WYPgqnd9Bxw/f6D1I?=
 =?us-ascii?Q?xVVa5LImkPbVqQlljReORWiQo80sDfTWZlisf+HOhv5GYeT6Gz6R8/DCJzOh?=
 =?us-ascii?Q?j88KWCyqqQRbrxUQyL3imIR+Q0Elb2BPf3FUsi2Tr5HR3Vc4AbNRg5Ag+9fj?=
 =?us-ascii?Q?3smWFMJbFFndsSK0WHzxpEPYQRKlz3npu/z2o+XpaZkVlZz/M1HzIe3YlTXM?=
 =?us-ascii?Q?xhfBTWnjMRXZVADEjzrDNzFiB4PmHpw5gRB5/ejCyTjN1XrGmwbgNvE6NKN8?=
 =?us-ascii?Q?xAcEeWWECSu2p6iUObaC/F4jqHlWfZcXTudIzcwL7VK1eIniyrm8YP6EvhsA?=
 =?us-ascii?Q?aFCkLKS0pZOYFzJuwvkuktSEHr2DzsDZqnElmA1XZx6EMWSIe0urvmLDY0vh?=
 =?us-ascii?Q?CvsbY3EwZjyIbcIISVE90fxtVYoB1LwutDc0D81ABVvg1FTwJ8prKymtmvvc?=
 =?us-ascii?Q?NoPbP8benI7ElP6ECNvb9ZpCg4T2536UPs2sRERoLndNEz/7cCCTqO7DUmGE?=
 =?us-ascii?Q?ah36fZQ4qtzKJ0vK3S0DOEKc4kfi4dJMY+K9mmX+hkC3o18heSOM0/HLc3BK?=
 =?us-ascii?Q?OiNVQKFPjBoon/k9PdL33dW7i+bdzkPfVgPYFtqumLI0/fbPjEqwfODyukuP?=
 =?us-ascii?Q?aYr0qTvMv/VVRnyxDMcG7GSKXwWJVWN7Wc5y+oGoFQFiML6/EGaLkj6mWVy1?=
 =?us-ascii?Q?/3TgA7RX9TWfHNg/PP0o4GrwWezB3Nf6F866Sm714cBi9Ef9wXBw+Q4k2qpb?=
 =?us-ascii?Q?D4g9G98dfT/wxrtoKeJEuvwXZ4hJySgH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e70ca9e-1dbb-4c06-473b-08da07c0e564
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 02:50:28.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3pUDyf8BG2WHJfqop3cjwOvJDeV5CLhYmBK15FhYV4GkCP9h72t+SwZqlvWVomLfB/+a/QEiHOPocwEAi1V1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2583
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Thursday, March 17, 2022 9:48 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: corbet@lwn.net
> Subject: RE: [PATCH v3] fpga: dfl: check feature type before parse irq in=
fo
>=20
> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Friday, March 11, 2022 10:11 AM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: corbet@lwn.net; Zhang, Tianfei <tianfei.zhang@intel.com>
> > Subject: [PATCH v3] fpga: dfl: check feature type before parse irq
> > info
> >
> > The feature ID of "Port User Interrupt" and the "PMCI Subsystem" are
> > identical, 0x12, but one is for FME, other is for Port. It should
> > check the feature type While parsing the irq info in
> > parse_feature_irqs().
> >
>=20
> What about this
> "Previously the feature IDs defined are unique, no matter which feature t=
ype.
> But currently we want to extend its usage to have a per-type feature ID s=
pace,
> so this patch adds feature type checking as well just before look into fe=
ature ID
> for different features which have irq info."

This commit looks good for me.

>=20
> > ---
> > v3: Remove "Fixes" in commit log with Hao's comment, this is a
> >     extension not a bug fix.
> >
> > v2: add DFL Feature ID Registry in documentation.
> >
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>=20
> Move up your signed off line before these changelogs.
>=20
> > ---
> >  Documentation/fpga/dfl.rst | 11 +++++++++++
> >  drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
> >  2 files changed, 33 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index ef9eec71f6f3..14f342bb85e4 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -502,6 +502,17 @@ Developer only needs to provide a sub feature
> > driver with matched feature id.
> >  FME Partial Reconfiguration Sub Feature driver (see
> > drivers/fpga/dfl-fme-pr.c)  could be a reference.
> >
> > +Individual DFL drivers are bound DFL devices based on Feature Type
> > +and
> > Feature ID.
> > +The definition of Feature Type and Feature ID can be found:
> > +
> > +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-
> > +ids.rst
> > +
> > +If you want to add a new feature ID for FPGA DFL feature device, we
> > recommend that
>=20
> "recommend" or "must"

I think it is "must" if you want to use linux dfl driver.

>=20
> > +use a pull request to reserve a feature ID for DFL. Here is the DFL
> > +Feature ID
> > +Registry:
> > +
> > +https://github.com/OPAE/linux-dfl-feature-id
> > +
>=20
> Actually we don't have to put all details in kernel doc, and feature ID i=
s used
> inside the device, it could be used in linux or windows or other OS.
> What about putting a README file in your repo to describe the detailed pr=
ocess,
> not in kernel doc. And we can just put a link to that README here.
> Then split this one into another patch? How do you think?

I think the process is that submit a patch/pull request to " https://github=
.com/OPAE/linux-dfl-feature-id" for review if you have a new FeatureID.

>=20
> >  Location of DFLs on a PCI Device
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  The original method for finding a DFL on a PCI device assumed the
> > start of the diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 599bb21d86af..6bff39ff21a0 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct
> > build_feature_devs_info *binfo,  {
> >  	void __iomem *base =3D binfo->ioaddr + ofst;
> >  	unsigned int i, ibase, inr =3D 0;
> > +	enum dfl_id_type type;
> >  	int virq;
> >  	u64 v;
> >
> > +	type =3D feature_dev_id_type(binfo->feature_dev);
> > +
> >  	/*
> >  	 * Ideally DFL framework should only read info from DFL header, but
> >  	 * current version DFL only provides mmio resources information for
> > @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct
> > build_feature_devs_info *binfo,
> >  	 * code will be added. But in order to be compatible to old version
> >  	 * DFL, the driver may still fall back to these quirks.
> >  	 */
> > -	switch (fid) {
> > -	case PORT_FEATURE_ID_UINT:
> > -		v =3D readq(base + PORT_UINT_CAP);
> > -		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > -		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > -		break;
> > -	case PORT_FEATURE_ID_ERROR:
> > -		v =3D readq(base + PORT_ERROR_CAP);
> > -		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > -		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > -		break;
> > -	case FME_FEATURE_ID_GLOBAL_ERR:
> > -		v =3D readq(base + FME_ERROR_CAP);
> > -		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > -		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > -		break;
> > +	if (type =3D=3D PORT_ID) {
> > +		switch (fid) {
> > +		case PORT_FEATURE_ID_UINT:
> > +			v =3D readq(base + PORT_UINT_CAP);
> > +			ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > +			inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > +			break;
> > +		case PORT_FEATURE_ID_ERROR:
> > +			v =3D readq(base + PORT_ERROR_CAP);
> > +			ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > +			inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > +			break;
> > +		}
> > +	} else if (type =3D=3D FME_ID) {
> > +		if (fid =3D=3D FME_FEATURE_ID_GLOBAL_ERR) {
> > +			v =3D readq(base + FME_ERROR_CAP);
> > +			ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > +			inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > +		}
> >  	}
> >
> >  	if (!inr) {
> > --
> > 2.26.2

