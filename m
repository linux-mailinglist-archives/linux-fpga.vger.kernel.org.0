Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741AA4C8034
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 02:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiCABMa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 20:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiCABM3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 20:12:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230336C930;
        Mon, 28 Feb 2022 17:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646097109; x=1677633109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4sYB4zOhbkcW3vLkpcuIW+rdg4ztlzDYiY47jwaebxs=;
  b=HdRgJ2dIsarZWGsXwbhnY8DJTnV9VZfQP4pnnKiR424srTrrdSa+dB0W
   m/jFPTiDoGTFrw7Ce87/WEt4fdT2Lk4QMAsKXMNl9IFppbZEAhi+oP21h
   Byf5AP/cOVHwHGM/owDwXx6qU3Gzen3603sA7K7QJKxtV/a2Eth/L3CfY
   nt2JIZqUGpWIzTPBlX/kb8I0Y0aBJfF17WV3LZXMEirCuA593c1WF1j0c
   xcwdLdTVTVOC65LwsEVnzllJtA/KugiRq2O9F8tVkgAOkJcs9nF2j66pj
   imnMjFntH14ao6cnM424zMkKiFfmLmacbrvFxCMDRUL0+WcAK3RH3t3bs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252760736"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252760736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 17:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="575527360"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2022 17:11:48 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 17:11:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 17:11:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 17:11:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV/j82M7JBPQapRUBUA/mKVhOcsoEZLcFegAKeDkpkSB3vCA+21+8HJZAAlVUhwP30YvNBN1Q9hWGwJienxKgUY65XRsekw8rFW2nkTImTito2S68km220a0epw571YcEwJI+I8GdvY5ZL0K25+f8Nbs0LNtWHSpv+Vw7JzOEYi2dshR3U6eD1ILeiRsr20mtJ8gMkh0OHXl6qrjvCa0cLEiLVNuDCPk9gL/gO5YkJRk3noxUAP3sLKmwxx6th75U/f445BSlod5IoebbLHTFPP0U+TFXTWtN5FVmM8ee87xjmjsc/n0sAPpt8sOrcyVRu1i56Eb0RuJz1eNoHB6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCG6cBU2ayBguOfCRvl2qFjr1kcqXsiGl6DWIu2UB+E=;
 b=E+lnt81E9dk47uJCY0vCLgMEs4rn6YXxxVIb+iu+YZy1s52TFc9xQ3lZpux33d4nzbXTgVZIDlAMNTVI7mL3vlml+T0IBMDeRww/nyye6AO/rc0PMZYdMr6vf9aMts6WizaFPOKFIFNMRNljorpmRx3Jj5Hj5h5zRrABWbVZmDQRLPxIFCbb0eZYIxeNBANQyIRE0ydK4thLkssT6F9BSp18RLPkAz85tGStk2gcolnrv4t3ryZzU6JnZmyzMHLNUVmXBuMI6kinkNrHr7bM1OgBVpp4KwIgsgvHNurTNzs/oc/DyNyxoZSdbX46lzcEliqm4f1wj8usl0UD7r8wOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB2728.namprd11.prod.outlook.com (2603:10b6:a02:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 01:11:43 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 01:11:43 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Topic: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Index: AQHYKWCMboctMLwByUuDsP0F5N+Bl6yo1LAAgADoPMA=
Date:   Tue, 1 Mar 2022 01:11:43 +0000
Message-ID: <BN9PR11MB548388C1E086059E277F4C8BE3029@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220224092242.127081-1-tianfei.zhang@intel.com>
 <DM6PR11MB381942D6F18C6518FE3556B585019@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB381942D6F18C6518FE3556B585019@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: c92c1daa-2310-41ee-b316-08d9fb20730b
x-ms-traffictypediagnostic: BYAPR11MB2728:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB272800F359680E53DE8236E2E3029@BYAPR11MB2728.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E47YmImenaryAcahOu6nafMfPO8VyFH11vXdOeSYnCHTeNyn1JVOCMSsbG1r2ueZ/+NfQa4Kj5fOPLQwwGP178hNBJifyovx+pd+ltZX0GDKha3Vo+DMMws/dPv7mVaa740itc+K1PTBqiv4SUtHw52LRUh9app15AcbYyRonlk6u/jPscD2H5lGO9ER9xztOr8kilYs+SIfGlRsKRC32I5h73MlmSokTn/3hsJASk2OBIMsv9REPvgvb+KgMNM1A9p7gfx9p39VutlnAZ+O+w8bFpJq9NhS384p6Avp03MWNJ00e9MLcI3PXw944vWOnhyHlumE/6eE3b4Kzbju+37Rktf5doEpHGvHk4mIwrSwI8hRcj3MBiW0fN9ex1ul6OfrWfRW80ReZSqbu26XCUBadG+2n0XbtQMawcxcxun1zGPFd/bTHwYvnvafIFRRY+IiUXFN0JoI1TEUD0djw+rVz6esymEfHZX1xG/45zgpc1RykDIzhQflaXuaq/AJe6gGtPGxDDzfEqGNocRn8UrWWua1fBhSii4Du5jLB6pbzcE5yXtZe44gwlRKo5//w/RgNWm6kKtrt4c6zECpdomOGwXSDrqk/Vg059TrqE+7R2fzEf1a3mUzcv93TEoP83VF8Z5A1h8qPfEXXLThLj5HOcb+5Qg74k8+TSidBqovlHcasAZtfvY9K+wnwmrnCjtXe+8JQHP2jHBHVy849UdHbeWGU5YbWoraWJ2Ppk4ogSl6Rvc8wfXe/MqJ3Y7arv/BWz5blzXlaxwFgJ3ZM9cozdidFRZWw9KA07B2mOb1L8oCeB/8LJSHslTQiAudkFLyuBddqRHBwjkgC1yB0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(53546011)(66476007)(66946007)(76116006)(316002)(64756008)(66446008)(86362001)(71200400001)(7696005)(6506007)(4326008)(45080400002)(508600001)(8676002)(83380400001)(33656002)(26005)(186003)(55016003)(966005)(110136005)(2906002)(5660300002)(8936002)(52536014)(38100700002)(122000001)(82960400001)(38070700005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PL1uU2Ypu1vYLnq/kvfQKYX2far8w4pvZC409suH2/JLT6kHaW1DaceZvoHY?=
 =?us-ascii?Q?GSfPKEieIFmKSj6Va3m9l7kinlpNjdGfEdXqQLvsWhEofjRUeY0uhc/BB2oq?=
 =?us-ascii?Q?RKNgT1GHQ8cnz4xnWKvWYA3MAxkrorJR2FBze3/XL3AoaBpDZyoyVCnzIrSW?=
 =?us-ascii?Q?ue9v5kGCVrBz8bHWAHFjv/Z76fffh9PSwFoOZlH65dIpMHGAGhLep2M0AaRj?=
 =?us-ascii?Q?EKUAYa2PQwDdCxadnnBzXQEvSSZrVXjcgey7WRDSbEUPTkw+9aORT/LRQCxA?=
 =?us-ascii?Q?pntYiTUxv6cNlhHTNe+khDaDs32aWj7NuFzOV0LhZ+aAQgK6dmszaRWIvhon?=
 =?us-ascii?Q?2rJ0rZJKY8FzQhe/ZPEUHfR7JcIc/Ak2/D8KMe6GwvAOVF043ZKRqYqpmiMo?=
 =?us-ascii?Q?h31RQuV53mLt2cws07xkRiltclwiF4RGfFLzHgRUc330fyq6e2ZoddtQ8Tba?=
 =?us-ascii?Q?zyojk4HaGqeCz4qFDGutsFADpI/+iNdinxN3wj5A8iPjKS8ZcGMIDjld/J8D?=
 =?us-ascii?Q?qSt+RuyDIQnaw2oev/U2glI8hcmvvnAUqmxo17oxogyNHpAOk81QuIyNM/w4?=
 =?us-ascii?Q?9eEIoBoTB08g9GPhGmnkeejiEW1FSvRiGt/ndWuvPFfFxY+/E3N+zcIKVjzv?=
 =?us-ascii?Q?azPpxBzb54A4xItJfrSuMhdtoKypvOCI6nQVTAQ0k+Mu0D0ImnvvpU9LhJG8?=
 =?us-ascii?Q?QOrZH3tDEUs6syqGp/rUbFKThntFX2uOooCTeHPJZVOC880VyF6vE+s0oWQ2?=
 =?us-ascii?Q?y0F4c1hpT3nkZF/Oo1P8A+0xHji1XxsQBwUR/JpAn8MYkDylseK2iW+1QjjG?=
 =?us-ascii?Q?sBh0h/08lPJMLifkA511uTZ8dzuqpHUF4RwvjR+vIDsXtjOsCbtuqHhiHXkk?=
 =?us-ascii?Q?HX31hMR3N3FfS9UuNbZPdW1GsPv4i0iPXz6G6BULfZBxpOZYCCXY8vNMs0+6?=
 =?us-ascii?Q?duH5FN1sOeluMxKhsROMdiqKHvL5l4UDtsJftXXglkK5oXhISpDFM1g6LHyy?=
 =?us-ascii?Q?voCc0lLrMR8RVxge9MUee8jbOE8iBJbk5qf8KeCOBouBbvSuGMvkt4mqToqt?=
 =?us-ascii?Q?+mG6nkNDeLwvOlWIUIfwAoO4J8ASfBcDl9M3pF5wenLMk0RN4lhENzZo4it4?=
 =?us-ascii?Q?e4wu1zNYz0vgsjTEMwNmxTdVoqL5I2SROW8SRAdCn3G8t8H1tp+y/MUOOJqc?=
 =?us-ascii?Q?nUuFFCyWeKwk7YKus6+X7XSKN6c75IC28YNQKlktYme22nU+lAI1vZvlS/cy?=
 =?us-ascii?Q?KnONdtW2IZ703H9Ig/OvCk5DBG5C6px2RBXFUE/JIh22wlm7fgcrKRdnSyun?=
 =?us-ascii?Q?oOR5KMXV70a+pvKR5v+BFtVUadrqT3G2CHzlGcfRBTyL/mqjO4IjOcslVKLP?=
 =?us-ascii?Q?IRIbYUrvigXqKNZ8ihiCZlJRO6yfO9kBPv9I4MZ/mcBzMmgFU5qGOzEyDz+r?=
 =?us-ascii?Q?1KppXQ86ddoHR06vVcD+2UIfazIWXahMYgQlzxT1nL6li8wJV8X9mpFJlo+d?=
 =?us-ascii?Q?CNqDRlhG505khoL7ZPhzU2nNfJC4cYVtkTDd67hyLKdqhfDEV/Wv4p9/I13d?=
 =?us-ascii?Q?bGaLnLvzES4IithuQdx87RKOyeI63yavf9d/928UKln9eOuU9Vwi12zH6CIB?=
 =?us-ascii?Q?XMgysynHhKStEjZBcbGVqFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92c1daa-2310-41ee-b316-08d9fb20730b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 01:11:43.6370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wV0f4lf7R5IYdoLUz8D3vIJeHYVsmUWRQkFk3bJfnHv/fOVv0Z7e5sxD3AcFob/BP8CYpPdltbJiVOBx8d4g3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2728
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
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Monday, February 28, 2022 7:10 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: corbet@lwn.net
> Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse irq in=
fo
>=20
> > Subject: [PATCH v1] fpga: dfl: check feature type before parse irq
> > info
> >
> > From: Tianfei Zhang <tianfei.zhang@intel.com>
> >
> > The feature ID of "Port User Interrupt" and the "PMCI Subsystem" are
> > identical, 0x12, but one is for FME, other is for Port. It should
> > check the feature type While parsing the irq info in
> > parse_feature_irqs().
> >
> > Fixes: 8d021039cbb5 ("fpga: dfl: parse interrupt info for feature
> > devices on
> > enumeration")
>=20
> Actually this is not a real bug, as in original design, there is no overl=
ap for FME
> and Port features. This is why you see features for Port doesn't start fr=
om 0. But
> anyway I am good with such extension.

I think this is a bug, I add some printk debug log in DFL driver, we observ=
ed that it was mistaken for=20
the "Port User Interrput" feature device while we are parsing the FME featu=
re devices, so actually it=20
read out the PMCI MMIO space for "Port User Interrput".

Here is the log:

[90273.482859] parse_feature: DFH_TYPE_FIU
[90273.482861] parse_feature_fiu: id:0 fme
[90273.482864] create_feature_instance: feature id: 0xfe
[90273.482868] parse_feature: DFH_TYPE_PRIVATE
[90273.482870] create_feature_instance: feature id: 0x1
[90273.482872] parse_feature: DFH_TYPE_PRIVATE
[90273.482874] create_feature_instance: feature id: 0x7
...
[90273.482895] create_feature_instance: feature id: 0x12
[90273.482898] parse_feature_irqs, PORT_UINT_DFH: 0x3000000200001012
[90273.482898] parse_feature_irqs, PORT_UINT_CAP: 0xbaadbeefdeadbeef
[90273.482899] dfl-pci 0000:b1:00.0: feature: 0x12, irq_base: 2779, nr_irqs=
: 3823
[90273.482901] dfl-pci 0000:b1:00.0: Ignoring nvalid interrupt number in fe=
ature 0x12 6602 > 7

>=20
> > Link: https://lore.kernel.org/linux-
> >
> fpga/BN9PR11MB54833D7636348D62F931526CE33A9@BN9PR11MB5483.nam
> > prd11.prod.outlook.com/
> >
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  Documentation/fpga/dfl.rst |  5 +++++
> >  drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
> >  2 files changed, 27 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index ef9eec71f6f3..9ce418da1876 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature
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
>=20
> Thanks for tracking ID allocations. could we also add some description th=
at if
> user want to implement a new private feature, then they need to submit ne=
w ID
> application to https://github.com/OPAE/linux-dfl-feature-id, and add some
> README file to guide people for the application process?

That is a good point, I will add this for next version patch.

>=20
> Thanks
> Hao
>=20
> > +
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

