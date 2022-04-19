Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F85066CD
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244867AbiDSIUX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Apr 2022 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiDSIUW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Apr 2022 04:20:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DF9273F;
        Tue, 19 Apr 2022 01:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650356260; x=1681892260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9MIyXDR6W/K++DC86WI3ibFBhBcR190F2qXm0SNG/SA=;
  b=chJlyQC57qM65LXRKmc2Pkq5TKwBsqiYiETNrgA2gS3p7caeLl6i506b
   nEET7NcVHRb7IAkn+iArtIc8+uWU7UiRb81gxrZMipA/FeHMrFzq1JER9
   39ZaQYbTwnUjEh0ViywL9mJIz8hHPERIj6MLIh4StVWQhI+LxGZHjb7Pt
   t42ID99UGHDBg5p5FC7MeAtr7uW4N63uhscFn2m087QO6FAZgZow9BSvl
   FkArcUbW5UifV8S+t1d2KPmmjJKMEmEg92m7C+VI70nDOrMF4I7wFdZhV
   fDT0aBxQwFapxQz4/AHCrFF27BGbHUlFgF9sIPggsu6RwmBicMKtzTfXt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261312542"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="261312542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="702105074"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2022 01:17:40 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 01:17:39 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 01:17:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 01:17:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 01:17:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADT5fKRK39Wr+1mlfXVlREDEVRT6/rgAa7cVccCCxMmiXPRquUhCdIDOZU4+x7xFgQTt39N7i501ZtEauNiFX559UXeJWp4iyi953b4gkrtLOM10QKb0AdAlXJ7WhsfLQo7duDLJ7kg8K+qeTsrOK9RybciM4b31sLC72xdQDyPdcMBob6tq2AHSSUYG6q260vJPlH6HF2/L1u/LcmfPa8kVSzBoodMOlxz8RWloz32yDCqOg55Sse5TA8VtCrPVPaXEdtvcfcyPd9p+F8wwRPbf/nvuU7nbPBggf7Rc8tK773MwnFpRv1g6B0bqpA++IhSeBFeocAKRYqjsIEQ56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiktgOcMkKvQflpgDbhpeUruNsjAWtxv3TW9L6DcXuU=;
 b=l1EXM3OIKw89+RTv3tKA87854IaufytVVOwvqYlrb4TI3fdQEvSyB4DgDLk5n2wE+D1LzR61U/WX3d5giiWWpSs21nE2uB4QwxyRL84uNOdVbw3U7E4rxvfnrXMWo1QQuWVmR5D0tXJ7QGL5ByPJiagQksZZu/5Iq2FHHwN//YP2EkKTWWamsVddtSljGRL+tw9bnZMx9OdjYiV5b/E0b6ex+ERRANzzHXW16LLNrZUcdRHaQ0smwVQocOZ/PZvAkSybai+uhxh0kfZmou5ZDl1l1ZrLahlKaDv2axrIZmi1wJCQhyImovp4Cn6H12IFbs7InmPjKGPpTKiLWfvV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SN6PR11MB3181.namprd11.prod.outlook.com (2603:10b6:805:c3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:17:34 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:17:34 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Index: AQHYTjZdVn4DreM1yUm1T9RcZPeV3qzypXkAgARHneA=
Date:   Tue, 19 Apr 2022 08:17:34 +0000
Message-ID: <BN9PR11MB5483EFD16305C1440107DB0EE3F29@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220412062353.53984-1-tianfei.zhang@intel.com>
 <20220416144752.GA301222@yilunxu-OptiPlex-7050>
In-Reply-To: <20220416144752.GA301222@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: bce8e777-7af4-4b9e-11e4-08da21dd0ec4
x-ms-traffictypediagnostic: SN6PR11MB3181:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB318128A1AC3F16C02A95E900E3F29@SN6PR11MB3181.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gqh9TjunhjJ/xrXIViHkOVdFnnvuaUkiLgQO70xsfRt2zc1cp1NbYYe5C3gjOTJfkT4fhntAL9EaIScS0F4FrMJ7UvUeZu77FkHJ+iMzLZtUopENZxiL3jrJ+o44CMM5fDgHLNJS10CLpbHf0ZfNM5lQJ/g7YWjzq81pXP5sjdQT0Iub1jBZGdpCn8OX01UWOIfoJC85ZQV0c/UrDoWDoErnQstf72+OgEVJhlVgRAyPIjvoXvBrV6y6FTycx79bykVRX4173dcQ7MdR81GfjH4ZgDEG//+kFHNeR2NKfQ0KbBLofPLuT01jipFiORBRJroKy6yyPQZSj2KPFjPmw8bDAX6xZdMqe2eLEuo5FWeFZYnndC0H1b7xnkTQsjQARhWHWRCL1swF447PG0mCn66JgqlacroIiXXWl8th5BvtoqvK02x65VJnmS/xfuUg+sN9TzBXQMVTzIn94FsciB8T0Kljz0A1vFI+uD5hyTH+ylfS2/Mjq3zQ7+q0u4zqnBaM79VIzPkGCXOMZqkgj2lbP2Fpgh30vhyV7sAyt1q/xp+7rg+oUUDsYVA0S3YZI9Qp5w6R4jmwU+yhige1ztQXX0iPPvo+vngMmWpg+HwQ81X03Q2Qkgynnz1Ga9ro2ypGcoueK7arQvUPquge2bZEW7c7/dGCZN7nhj4baz5Lxi3pm5/nx5V20GeR6TMH2L3+UlVCmMClXF/hIvrCKFqT36QsBB2YXAhYLcjxd9si/7cmPLjMz5Ma4pO+z9va7moZQH/5R0OznEmxl2uPKchZYElANN0xWnvKeE2+KE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38100700002)(38070700005)(55016003)(122000001)(54906003)(6506007)(76116006)(83380400001)(966005)(82960400001)(508600001)(7696005)(6862004)(8676002)(6636002)(9686003)(66476007)(66446008)(71200400001)(66556008)(86362001)(64756008)(66946007)(316002)(33656002)(26005)(186003)(2906002)(8936002)(52536014)(53546011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?59qiO1Wx//dtNQBhIvE7KvLOKrkelHvC4CF843rCGqlLVeVxjYcAgCQ8U6F7?=
 =?us-ascii?Q?qUUrl935PuYuSHHC4ww6nmwaHSlxAGq/wkdehBtT8Y1oUb2j2kk/sNponZyg?=
 =?us-ascii?Q?CY1OgcX00/Pn5uC8hwlCAo7aByRsuxqJCDx6MyACjW1i4NfO6cb4rtQ6q0nC?=
 =?us-ascii?Q?iVoYJ7Osx3l6bf0s7kFlbbARTac4zQ7ewBhz3K8EEdSLiQc9GZbjo4swk6qc?=
 =?us-ascii?Q?UkjsDZm7zPUx/Pm9sIaoPJeeiBgFCDD6Xd7QtDvO4TmNaF8ZVMeK82hdoKeC?=
 =?us-ascii?Q?T7+chh8/Xrhv9403fy2eAPSSMmrigS3MK0lV71kH+MobDzY4oQxhtxbHtox8?=
 =?us-ascii?Q?ebaxC/TdaqTtj5JXEnuhg9oTG2ZIt5exJ3qz3lprvw4eQI0d+B46IBguj/M4?=
 =?us-ascii?Q?0r2WdYEFmhcV1eejlUdyNwKkWr0wOD2bUaOgRVoOToLR5mdsT1rSU8IUWqNz?=
 =?us-ascii?Q?95wm3+pyphMmvLPjZbG/ssHjIU9NKBtZltfx42BuyKppANFKdx7kY/KibrA8?=
 =?us-ascii?Q?l79cxojly1bnf8atkz+FlH0f+o6UJDN233/54LeF+Zh00W+U3FmrQfPXSK+H?=
 =?us-ascii?Q?VehUiV4w+TC+JUvlwkW6eymIo4VWj+pWryeMjvmA/5OmQgb9pB3ZKK0neAOC?=
 =?us-ascii?Q?BmQn8OPMSUSmPwoJDypXs/QINmahUjzp6ml5guyXqrNvqFeIqqhNWSMKSRLz?=
 =?us-ascii?Q?EPgrHvDHZ1Tc5FYHWRSj4mRFS6hNXMrE+O5SSv+rqvzkGz0vqf0Sd0jbRJJS?=
 =?us-ascii?Q?2mzL2N0cwzmnl1f0K/6nG1DU6Ep8jamZ7ce7nBOVlPElb1lWuaxNvs8VYZR1?=
 =?us-ascii?Q?2oVrrfTMo+chdyH/1AWvRFbwROy54LxABc7nwa6tRMgTvrtVW1uU8Hv2zQ3r?=
 =?us-ascii?Q?U31bMqejudWIyVBB0ebcFdREL+18S7GAAOYEgGb8KMPm8ezvf28TCagBjhIo?=
 =?us-ascii?Q?BXiEHSIpJQGYUSfZTEOvbapukTv7D2bYp2kv3ktCBFmD2pQmV7UC6jZPOjPJ?=
 =?us-ascii?Q?9fYsTnzPsN0D3Pya2e/kW2hQd5P0XNV9WYgVxN5aQCmJnjopTWrEk9Q/7mo6?=
 =?us-ascii?Q?bTIB9n6jglcdvYgM1SfOOyxkUx3YyytVwjgrH2Y22LVlD5gM3jd1+z4XISuj?=
 =?us-ascii?Q?LCylRkTCkU0qewbCHZyhnILYnANm57nnzwj2TQHnIEn65dbZIqq1vfukEpWx?=
 =?us-ascii?Q?pBcYbHJu93Tl+jxJaRpDIgBMYsB+VWayBWQnLXKjPPbAq4cEnT7eYXEHwQfA?=
 =?us-ascii?Q?/A8fUCgqfP6eFipdDHL1BIkgxwQXq0YJpiB2YZZZCmbOlPswqd5skqdYR6+W?=
 =?us-ascii?Q?64nRFMrv82Ulo7d2hDCme/6ekSLlYZrdujVPqrZLTxiykdGBbebzWV+4M0i6?=
 =?us-ascii?Q?NmFivPbfkDTOSLpTod6o5CPx9h2Q8fegRybV/Tye6D0LqRIzUbyW7Px4Ki9p?=
 =?us-ascii?Q?5LsKnreRWKpXXOl0j4PJ/sNxbBYIc37/0s8MdRyVjDvJQFMQgWej4EPRRs3l?=
 =?us-ascii?Q?JG9KLD6Lgb7IZH4txnRgyJ8BgBMjRfGmlmjo3PKQ2ILyw9IEYa7PStFlcDoC?=
 =?us-ascii?Q?cN56nPWou18lA0jtO0yCsCzJu8k0gHPqQ+EWo0qKlQ51oVLbrhhPW6r7AEfT?=
 =?us-ascii?Q?g3C3p291JzBDIs/UZxRCkzy6Kip2sYNh4eQmexOtJYGpn0zd2CEOnspuyhLR?=
 =?us-ascii?Q?D2p+dPuJ2CsByvm1UlWRWCro6nyJNfdzNGY+KvO8/7pbXFq5g1+WRpBpVhb6?=
 =?us-ascii?Q?1sCbUKEdfw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce8e777-7af4-4b9e-11e4-08da21dd0ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:17:34.4628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaF6jyMI5RYDW8GxmN90OE5/j8R0oGgPuSGFQ5r3SdhFANRc+vj+2jJ6Me7yIgs5GCAXHLYB4713kC3WyMIFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3181
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Saturday, April 16, 2022 10:48 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; linux-
> fpga@vger.kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: Re: [PATCH v2] uio: dfl: add HSSI feature id
>=20
> On Tue, Apr 12, 2022 at 02:23:53AM -0400, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Add the feature id of the OFS HSSI (High Speed Serial Interface)
> > subsystem to table of ids supported by the uio_dfl driver. HSSI
> > subsystem consists of harden/soft Ethernet MAC to support various
> > ethernet usages and PCS/FEC/PMA direct modes for non-ethernet usages.
> >
> > We leverage the uio_dfl driver to access the HSSI subsystem on user
> > space, because the HSSI subsystem was designed for specific purposes
> > and does
>=20
> Could you explain what's the main difference between this MAC and other
> MACs, which prevents it from fitting into net kernel subsystem?

This MAC in FPGA has not implemented the full functional for PHY driver, we=
 use uio_dfl
driver for faster verification and product prototype when we reload a new f=
pga image. The
major work for driver include setting the loopback mode for MAC and getting=
 the MAC statics.=20

>=20
> For FME_FEATURE_ID_ETH_GROUP, it is not designed as the full functional
> ethernet controller. It is specially developed for the Intel N3000 NIC.
> Since it is an FPGA based card, it is designed for the users to runtime r=
eload part
> of the MAC layer logic developed by themselves, while the ETH GROUP is
> another part of the MAC which is not expected to be reloaded by customers=
, but
> it provides some configurations for software to work with the user logic.
>=20
> And what's the difference for the FME_FEATURE_ID_OFS_HSSI?

I think ETH_GROUP is designed for N3000 NIC card, and the HSSI is a new des=
ign for N6000 NIC card.

>=20
> Thanks,
> Yilun
>=20
> > not fit into the standard MAC and net kernel subsystems.
> >
> > The Feature ID table of DFL can be found:
> > https://github.com/OPAE/dfl-feature-id
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> > v2: add HSSI introduction and the git repo of Feature ID table.
> > ---
> >  drivers/uio/uio_dfl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c index
> > 89c0fc7b0cbc..660e1d0bf6b9 100644
> > --- a/drivers/uio/uio_dfl.c
> > +++ b/drivers/uio/uio_dfl.c
> > @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
> > }
> >
> >  #define FME_FEATURE_ID_ETH_GROUP	0x10
> > +#define FME_FEATURE_ID_OFS_HSSI		0x15
> >
> >  static const struct dfl_device_id uio_dfl_ids[] =3D {
> >  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> > +	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> > --
> > 2.26.2
