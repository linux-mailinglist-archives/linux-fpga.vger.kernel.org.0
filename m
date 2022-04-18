Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505C504ABC
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiDRB66 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiDRB64 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:58:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9506A18397
        for <linux-fpga@vger.kernel.org>; Sun, 17 Apr 2022 18:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650246979; x=1681782979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R8WTc7pxbRQzF1m5bZiaJ4Q437gYegDJmHPRJqKAsjc=;
  b=S74uPcix24kmLQZ+YTnGnWATwp63pWv3KbtapiKh64oNtATGc9rUR1Rc
   iwQfpkit+/DV+wes3/8jMCd0pi7GKwl5eZIa/e4elMtlM+qmFBODDmxhA
   W6ZtGdUVy8BHmhGYW4SKpFd1GVRJV3QdkwKH+k2/orpAvauqow4NR0AtM
   onmu4tX9oN64W165wyFflvRcgTe78daSPVKpb8LeW4yGXEk4TYh35A5r0
   r1kcwp8BPIoexQezLXyNsa6P5gWa2mMdYez7X9DLzTx0nKdnlKDqE/dLt
   M9q0mgz3RYjoUxUBv0kDPGtE97ZkeuJF6B9DtqUVwm4O8/SIAmtKz94qG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="349882571"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="349882571"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="804135659"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2022 18:56:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:56:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:56:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRTV1Q6hv1YrqVJ18soq+HPrND0gQ4hOw2twHXVq+4g2DkaZDE1bW07mGGc4RqSQk9Hj4aDHQ3sQeQ6ypY566HDLYAXqmiK21LF+2LF1RJZh+D4kgy05Jki4kD7mi7jKfEQMucUxxupsq9US0godKCz5UMDBT6cS0p0+8shkxL3y1shn2/7b5BzHhq2r/DCzKJYrqY3liscBY6Z1jsXOx6b90lSXNFx4aEjJ+a6QAIa6LzAA5ASAp+fCubgUR6oaZtMf6A57nSbKlvwWoDTvLHV+fW8iyL7mGWwcRdCW6bYWuvIdQfjSfU+nNDEepFSqByehcrdYGD4EnQ9DmgMNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WW8nVBl4cxZ47eTjWgivb6hmLORTIXPZm0+YVdg8i8=;
 b=ibpuT44Td9/JGn5xCb7M1KisN8feXidkNuduM4vWQnxonI5kF0JeZ9xQNu4YLLjnPouf6P+S8Wvm/A3eUz4UhbbVfJO7P+I2bG7vTOoIqVBBcwiiDHdSbg5w7U10k4XCYGEB5e25GbbbJGL8Tg9Ojvkk8J7vP0vuZehsB8shCzz3rLNmGK9fsyvIGffq8ZIbdMoRV5+7dSVxy4NK2ZeIGDX7mLZMaDe3ljHxPyydRMvpRA/udtZMYmH8ToZ49tWrg6Br4/sfo01NpdaMxqWyw20GWdc5c1OwFhmsR4cIASZJn4kVNY2UJ5+etS6wHO6fuvr8V6aSQBa2k1AuKb8cUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1578.namprd11.prod.outlook.com (2603:10b6:4:e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Mon, 18 Apr 2022 01:56:16 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:56:16 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYTxeAK+xZBhNuiEywd4yPTwpOoKzyvPYAgAIoY8CAAArksA==
Date:   Mon, 18 Apr 2022 01:56:16 +0000
Message-ID: <DM6PR11MB3819CCEB3AD0E0214252044685F39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220413091519.317735-1-tianfei.zhang@intel.com>
 <20220416161814.GC301222@yilunxu-OptiPlex-7050>
 <BN9PR11MB548365366CA105E3D05E1A06E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB548365366CA105E3D05E1A06E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 8cd671a8-7ad6-451c-3cc6-08da20de9ffc
x-ms-traffictypediagnostic: DM5PR11MB1578:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB157807FA35218E5C8C18BF3785F39@DM5PR11MB1578.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvNT18OHjOeTHjlg11LQBsdooLAoM+m7GPAR1nC2P7PJ6xSEyQG1J8wTQfFifArIMvcqUFBYxePKT25oRMMsZTAS8jKved5grY3rx+LICbqagvoXQ5RhTedxwvQZboJAAoyfqbV6CCFBNg1X2GfW+90EHTuR/cSZIG+ka9rBIXshVfvVKAFPQ4LzUS8F59cFMW0p4LM/C5qnUyd2KZK3U8Z0qRr1aktr7lLzqHm+0Oj2J5R6uRCa7HAwGX5vmDhE+qC+SVGE3cWVtpEfohebK+i0VEPFf9R0QgA/9G1/jCWjPwJgiLi8CporvZiHP8D5DWjDt55r0QeiYyEJQoJIzTbcFjN8sjQTLTBX5Aa3ifIG6hHEEJqrvDJ2A5bkKwS9SSzhicHM5qzssAkh8LhwWcPrDLxaN1Ek5aU/zh7eAJ4rhs+zMjaaKj4eiSUCC0HO+uggE1gCdDb3RxRyVZCTydBh07+S7m5Zw+7KDTvJFbitVhQ0evYdAp4SOcB7HlYHTP76V3TVCvoJ80FPM+FEtcY0VAroDHBHYUbUOfQPyKtaBiyKY3OSXR4nPxAuSW4MfMerfmPDscVuz96cme9dS8U7CZGXZAESe4l5ixwaMLdkt5l0UoNR2iXsmltRS3sC53N/j4GlMEncQTnauFowi7Hw4ZdyjYzmCTmBiwqQUujAjCTVy2lUCLG147VmDWHiX8qJdGKtZGTzlrSFwVHuM7Ba2eGlIizOThAMtHBu0oVr+6O6UrbKM3Xe8/pZBULEurRm5aoqbSj1Ml+WOOfEk2FVBI4AuoYsxkN4BHWkJhI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(71200400001)(8936002)(82960400001)(38100700002)(966005)(76116006)(64756008)(66946007)(66446008)(66556008)(66476007)(122000001)(8676002)(4326008)(52536014)(6636002)(186003)(26005)(110136005)(54906003)(9686003)(508600001)(53546011)(7696005)(83380400001)(6506007)(2906002)(38070700005)(33656002)(86362001)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AjqUFTVHDjhkQMf0PBl1ab51qJufcOSVb9sn5MnE4pvnhyxhKZa/HjNjYDkU?=
 =?us-ascii?Q?rGYIz/4NQ0qb6p+GL8ufHa7D8QjqMn0Ev8EL7n9633hAOIPkO627v5V6ml8b?=
 =?us-ascii?Q?4utPgZcvP0WpNnPQuWGOa2mt0QfLFEo6gEpK23/TTcUEw40iAPKeSFc7bBdc?=
 =?us-ascii?Q?wnHvVdmERL6yvTUo1qTZs7jgwmImYwwi+9WMDmuP7bwGj+5mRvv3uSj0B7qg?=
 =?us-ascii?Q?2eNxVBPYqTNoLy6frvyEtkl1hMxsQ4U3UmqTzo1NkWS08bYB8CTuOBJZe1TN?=
 =?us-ascii?Q?tyIrTfRuu4O/c2xeqIh/we8ppef68wia59qrbPoaE0nWM7Jzf8xzLEEAKGWD?=
 =?us-ascii?Q?Bh6nV7D+mSA3GUCytEl+H2t/IVE9XeZn1wgXSqSp3mV5mzLOIASxYGVcHCb/?=
 =?us-ascii?Q?5RN3G3LqNnh+TfdlefDh1aPp7OSxO3uoIOMzU1JVGsF+Y4aPE+k5KZVNLvVD?=
 =?us-ascii?Q?ZwDba/Oy4gX3TubPzRzG2T8J0XXaYr+v2x/fhVfF5BQH6mLtypjlrqXr4NlW?=
 =?us-ascii?Q?MPaWi0HX84G7F0SyfjrStsqdMjeY/i/j5h2Tvo9cl2A4v1rVuqyXNlVR6YNN?=
 =?us-ascii?Q?+P6Qu2DH1HLNVEp0gpFWskVIXEMNYhk1mr1Lceswu04IMdbOh7JCMNkgF9M0?=
 =?us-ascii?Q?IqfMTUxE5lhMj5ncoStlZSIqLvrsVoWYThXr4q/Nfk6wZUuTmuvsw95S5gvZ?=
 =?us-ascii?Q?qsLJyyeV4Vaja6Ta6gL4x+jQya9B2+EeL0r3x3B+A2tbqHlJ2SGD/l/U92pR?=
 =?us-ascii?Q?r1oIWAzpgkMIlgpfsOPdRYb1/Pw647V2caPgpew4MhLrixw10JPfsOKE3qZV?=
 =?us-ascii?Q?0SrBkQbH9hWwlS4MtPTKDdIPqEQwqxQV8y3GmtxgcabR1YCwqCPfWNrA25Et?=
 =?us-ascii?Q?j0pnDbRatWOAcKrmGjSYmSPrmUvA0fBccBmQLonW4A/ZDHOOWfFfwK66AAmx?=
 =?us-ascii?Q?tGitbOsRMuK5VY+GYGbCq6fPiS7xwztVFm1sGMH6/ic2MHV/5gRIfBLxy7pp?=
 =?us-ascii?Q?zgPespQ0Q2wZ+1mDMGBt1i7NIrSJHUCd+z6ta1FknkHzHagFC0BqwGqvGvro?=
 =?us-ascii?Q?i1y39RLNivkqyQG3L+W08H/30lHrfZbZT2sfmncSa77U+cU+++7/QumyPS6E?=
 =?us-ascii?Q?SBH7heY5Igg3KvfD/PJuP2EpAHxLUBeULiyfvmuWfcU4NlbQruYX/W+sT4Rk?=
 =?us-ascii?Q?IiWNLk5qg5E9co5MSl+OkzdgkmmhKJ9cmPAOZvAPyrM+b+su1WRiOUZkEVH6?=
 =?us-ascii?Q?2rcigpi7lBJ0JQEEVPBO7FbNHQ7VABG0It8Pc82yjRdTpbGyDHOUf7RCaH7P?=
 =?us-ascii?Q?sjSP7q05cWFzfyiRVkZw+JcRV5kTdzruXTOn3DEH+QWVG6NAVmm/78gQNRaJ?=
 =?us-ascii?Q?26t8v1no8SvCM79PchdZE5JTlJdfYHTRMDSMks8QbfZFnn0KoS0B69Tb10vE?=
 =?us-ascii?Q?9PW/kqsQnmcHcJOAWgFFCjN7HZKO04BGg7GcvBn7+U/dox3wIe3tdwpmfX0M?=
 =?us-ascii?Q?hGo6wHymkD6yPXugo/cYWaTY0y2oyk2ChppVZ/XHJx7z22+m550XbB+G51cz?=
 =?us-ascii?Q?3igtHRo1IuAkqYFzPCo4efRpE2/bhrl0CB5RU7R/X6NHNXP3b/bMxUyPhRxp?=
 =?us-ascii?Q?OBzHz8X3/A7Tjah0Ge60D7I5/HtESNN0dIGu2EGL4WjrLbNHO+KbPURZkTc4?=
 =?us-ascii?Q?HUVdC0T6idXa156+dKjx7kZF+H2aU4XfGA72QB54LpkY7z8721E0jC93s4p0?=
 =?us-ascii?Q?CQ+DDC3W1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd671a8-7ad6-451c-3cc6-08da20de9ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:56:16.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHwPcnfoLbXxQVMQeAQiFj7q2cEQbQmXSeEPe2x1UnInw6yMBB+/PVHIUfYqglDXfQ1s73PAbW/vRx1pxdnt5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1578
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

> > -----Original Message-----
> > From: Xu, Yilun <yilun.xu@intel.com>
> > Sent: Sunday, April 17, 2022 12:18 AM
> > To: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; linux-
> > fpga@vger.kernel.org; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Subject: Re: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
> >
> > On Wed, Apr 13, 2022 at 05:15:19AM -0400, Tianfei Zhang wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > >
> > > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are
> > > not connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack
> > > device), PORT DFLs are connected to FME DFL directly, so we don't nee=
d
> > > to search PORT DFLs via PORTn_OFFSET again. If BAR value of
> > > PORTn_OFFSET is 0x7
> > > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for
> > > that port.
> > >
> > > Link:
> > > https://lore.kernel.org/linux-fpga/20220316070814.1916017-2-tianfei.z=
h
> > > ang@intel.com/
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > ---
> > >  drivers/fpga/dfl-pci.c | 7 +++++++
> > >  drivers/fpga/dfl.h     | 1 +
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > > 717ac9715970..6347f31058f0 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -259,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev
> *pcidev,
> > >  			 */
> > >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> > >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > > +			if (bar >=3D PCI_STD_NUM_BARS ||
> > > +			    bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> >
> > Seems the second judgement will never be triggered?
>=20
> The value is overlap, but there are different meaning, " bar >=3D
> PCI_STD_NUM_BARS" means that the bar was invalid during the PCIe spec,
> "bar =3D=3D FME_PORT_OFST_BAR_SKIP" means that the HW tell us that the SW
> should skip searching the DFL for the port.

So first case is a HW bug we should return error, and second case is a vali=
d
case to skip searching DFL, right?

>=20
> >
> > Thanks
> > Yilun
> >
> > > +				dev_dbg(&pcidev->dev, "skipping search DFL
> > for port %d on BAR %d\n",
> > > +					i, bar);
> > > +				continue;
> > > +			}
> > > +
> > >  			start =3D pci_resource_start(pcidev, bar) + offset;
> > >  			len =3D pci_resource_len(pcidev, bar) - offset;
> > >
> > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > > 53572c7aced0..e0f0abfbeb8c 100644
> > > --- a/drivers/fpga/dfl.h
> > > +++ b/drivers/fpga/dfl.h
> > > @@ -91,6 +91,7 @@
> > >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> > >  #define FME_HDR_BITSTREAM_ID	0x60
> > >  #define FME_HDR_BITSTREAM_MD	0x68
> > > +#define FME_PORT_OFST_BAR_SKIP	7
> > >
> > >  /* FME Fab Capability Register Bitfield */
> > >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> > version ID */
> > > --
> > > 2.26.2
