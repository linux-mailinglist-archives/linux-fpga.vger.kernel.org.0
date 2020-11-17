Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E22B5C78
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 11:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKQKAt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 05:00:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:26338 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgKQKAs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 05:00:48 -0500
IronPort-SDR: sjl3Tv2m8m4M3MbkLnyOnL7rG1cQ2aJwc35NGghSAbl0uChN6HtolML2qwUuLtq+TSFSy17B1J
 cMQpk1T2PghQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="170996783"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="170996783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 02:00:26 -0800
IronPort-SDR: 1kANeuKaO+0oIvx3f59wlBRhWpgrvf1cttPvTPSZuoW75qRncAPP+S/ZiTMMVOxG+Q3KJ42qpY
 xfgyFS9rOAXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="543978452"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 02:00:25 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 02:00:25 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 02:00:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 02:00:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 02:00:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlgVlxTaXetZ7cZY8ntMjyNdG6UU68VGX/3Kg7ZWXdnQ/ZajqC+TrtsqgYVlopfEwzvff3jwhG+J/nlYa7SHVOYfQ/XB5tH9EK4OYWw4aoRp1/vV+Riy1e1frm2IxOH+WaU0qKAggzvxPKyRgW3qNrY/RWLvznfWVgosD33BEJLXLi+K7agr4V0IQiMWXA1BLui+XA85cXpghiUd4XWzhCDLkbpUb3Drbx4ABNZ3vI54yFB8TfGwc0xjs8wwk/ib4SpSNVmjot30HXqvPmTVh53ztkiiAVCMlfbKGNScLaDE7bCVClCWSy1EcjWwcpOcp61Ox58MM442OLMWwQUSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWNkBqwRQ73YFf4f6l5nJHVvCMwTxSh1DWE9jNoLVgs=;
 b=K7oYIvEFsdfqVQMC5KMdmSh9zvXNkfL4PtxF5TZ1HG3M8TS9sASe2i1CiC9cKCZlwUNGLggObQjAa47ZItkTGwDQKwQC7uLJ3G1R+3bfOyfschnvXUkrUSj3a5hj74hWRdgxjz/1IfFa/QvHZl2g/IdlfbeWZ+ReLJWqyqV+yx9NJ6ZCgOuSs+5R+e5NUS+ZUFwKPpQwmtsc/38cFHCGXGvF6G/tv30NgAiAbQGkAJ1pa55BJ6GtsQAhvJOteYkEt5FMwGrVcmzyr5LZL94mP+7UFqi+fNnNXmnfnwkVauc6aKVsipxy/TFStY1w+VM5qxB3LKpHESRpyXVvfp2mMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWNkBqwRQ73YFf4f6l5nJHVvCMwTxSh1DWE9jNoLVgs=;
 b=ztFnqOJS2zuUUSkkFYn9hA/V+hypnxdmYU6kGQK296/dlUGRQhyobKako/ybv0beSleC+D86bwd8+NbvBZTuITOJDol8o6l3LPjs+5Jy651zTvBpmCDq2TlKJJR5Ngc7sALdDxZQogr/nTsKmYu2A3Z326VpIovfBCULrkWwh3w=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1947.namprd11.prod.outlook.com (2603:10b6:3:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 10:00:22 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 10:00:22 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Thread-Topic: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Thread-Index: AQHWvIBxykoMIcZrHUW2ir3zzcjKk6nL9UsAgAAf7jA=
Date:   Tue, 17 Nov 2020 10:00:22 +0000
Message-ID: <DM6PR11MB381900B67DE65EEBF936CA6885E20@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
 <20201117075626.GA14665@yilunxu-OptiPlex-7050>
In-Reply-To: <20201117075626.GA14665@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61ffc74f-a6cd-4f3b-a6f6-08d88adf9924
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1947D41988810F9D62C7945E85E20@DM5PR11MB1947.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olhvXjUJcsBF+4b8VvaXZHzI6FqGf13HCGQ262fiYObltFRKqn2kFxfqXlot35oy2PLUagC6cStn8RXWOZ2lNcVqSQTV9HYZ/fEczIh6uqkjs3zmAUjK63kavoBwhDcJmL6bxwmrv8AeKTWTAPBPFruVa99llkWwYk3X/Zol2o8U4T+eJrhK4FE+vhfwAyfkRBHoI45ynh4ga+wiYQ/SCeFWseneCNeB3Tiv3gWIQU0TqdXU+phU5EdJb9VRnPM3H50Xm1ekqwKxbFQdHn0Hixd1KpInjjjFb4SPs0leAntXyFGF6cbKMYzCgz4NIQ5ucycJFViNVEVI3ZMOjJK9vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(9686003)(4326008)(5660300002)(66446008)(64756008)(55016002)(54906003)(478600001)(66476007)(52536014)(66556008)(8936002)(86362001)(66946007)(2906002)(8676002)(33656002)(76116006)(186003)(71200400001)(7696005)(110136005)(83380400001)(26005)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dofraMg6ZBaHdMd/G1Aq0MSp/eZHgmxptWF6BIUIqubkyYf5PhXNFG5LdT/VjVinFyAF9exbQGeKmTWZljFj+heGa0xPx7HOjKV4yGWWSVKZMHnxfc9Jsj0j+/nQJrwk53eAJNzF6Ag3PO7xX3JN3FZneJGzW/4cHpzKXNUycFKrPhPGreSE/dPVhEqtxD4AjSz55HBE5KsC8hlFkdaVdTTyKZAgpZEKG0Y4O1XFfDItEpLrW72vbUkaL3Yah2NYHQ0oWlZQgUO4Cn8QlIe+Ga/vjqUtUAmPgDsedWcDs8u6sev7l8wg3XldN8XzKrdhuZ4O2cQk8GKSCViCQm6cNoHR/WSqiEbfAOp5lg6dd3GD3RWZ/QiKnEReTTTQc5RytztNP6g7uTYUWlSHht1lFvBEv03m+0M1YYWGspFz5CwhO3+3/4bBh9qaHGG7+Z1jVoYWWkIxP+YdC+UE10nZEPJQW9/iaMGCGLQYMsLApGvg2Au7/Jn3rfr70GJN6J15pvErN4ynnX+pYicron5tyyzJ5ND5pgnQ5upLtLz4YBzB4/b3GuMmDRJRgb+MDy8yBPXPsG3lTDeIGAZPmhmga6/BVWSdJyBqC5bHujIHznUgLOH+Q3pdbtakHQAX8YSDfmYgqyz59PBe8vD5DnoIiQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ffc74f-a6cd-4f3b-a6f6-08d88adf9924
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 10:00:22.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozyFfL6E3dmBM7VZXhaKaRToBgnLAhCmUL1k8CYE0peP+oqBoIhjuWN/KI8MAx2D5zgbqp0qzPkC4ji6LT6Evg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > +
> > +		start =3D pci_resource_start(pcidev, bar) + offset;
> > +		len -=3D offset;
>=20
> With these code, I have the following assumption:
>=20
> 1. There is only one DFL in one bar, multiple DFLs requires multiple
> bars.
>=20
> 2. The DFL region is from the "offset" to the end of the bar.

I think we should not have such kind of limitation, but at least it=20
requires user clearly from spec, to make sure no overlap case could
happen. We all know that BAR number is small, but we won't limit
DFL numbers by BAR number here.

>=20
> Are they correct? If yes maybe we should specify them clearly in Doc.
>=20
> > +
> > +		if (!PAGE_ALIGNED(start)) {
> > +			dev_err(&pcidev->dev, "%s unaliged start 0x%llx\n",
> > +				__func__, start);
> > +			return -EINVAL;
> > +		}
> > +
> > +		dfl_fpga_enum_info_add_dfl(info, start, len);
>=20
> Do we need some region overlapping check in this func? So we could find
> the HW problem (e.g. same bar num for multiple DFLs) in early stage.

Not sure if VSEC can add a length field for this purpose, otherwise overlap=
ping
check only can be done after enumeration (walk the DFL to know the end).

>=20
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int find_dfl_in_bar0(struct pci_dev *pcidev,
> >  			    struct dfl_fpga_enum_info *info)
> >  {
> > @@ -221,7 +304,10 @@ static int cci_enumerate_feature_devs(struct
> pci_dev *pcidev)
> >  			goto irq_free_exit;
> >  	}
> >
> > -	ret =3D find_dfl_in_bar0(pcidev, info);
> > +	ret =3D find_dfl_in_cfg(pcidev, info);
> > +
> > +	if (ret)
> > +		ret =3D find_dfl_in_bar0(pcidev, info);
>=20
> The patch is more than the relocation support for DFL. Actually it
> introduced a different way of DFL finding.
>=20
> Previously it starts at bar0 offset 0, find dfl fme first, then find
> dfl port according to fme header registers. Now it enumerates every DFL
> by PCIe VSEC.

Yes, the name is a little confusing, maybe we can rename them.

find_dfls_by_default or find_dfls - to handle original cases.
find_dfls_by_vsec - to handle vsec case.

Thanks
Hao

>=20
> Maybe we should add more description about the change and why.
>=20
> Thanks,
> Yilun
>=20
> >
> >  	if (ret)
> >  		goto irq_free_exit;
> > --
> > 2.25.2
