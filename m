Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3FA1D2707
	for <lists+linux-fpga@lfdr.de>; Thu, 14 May 2020 08:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgENGG0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 May 2020 02:06:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:61729 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENGGZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 May 2020 02:06:25 -0400
IronPort-SDR: 6FtP6rZlKTVvoaS/Iv6G288xQx+lp5U0/QYuc0ryCZ39qVXdk4bBRFh9G3WP/heV2RMcpg8TiF
 1CqVBpaGHCKA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:06:24 -0700
IronPort-SDR: pjpswNHL1LItcqQqR0fzRL65fOpKrj/ga7S2zR7VS3eQ4cbekctr5P9OPZKMt9jqWnx6CAQmMF
 3w8qJ9IVCRXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="297917468"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2020 23:06:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 13 May 2020 23:06:24 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 23:06:24 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 May 2020 23:06:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 13 May 2020 23:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwZBNKXeV3HIwNwVulLFM4f/XM+j4rks0B5QzZqwnHZKmTgWGWb5vrnv9ZMnaYS06ohOvq/+oc126z0ZaelwtHp/V2Kjeg2p+cyNBf6eyTXcXqhccThWqsIE3Ed/XjJQccjBy4m2DNmbkf90KTQRA4QfRp4dGFxeG/dsUPnB/tMnef8yqV2irRtRhpu/VrOV5+Y+y3VRFlzrtHyYBW+Ai4PY6RIhHl1OCfYV95ZaseT83Wns7sE16UqSg8tK5UWUaISb+eQBrzRqpvcQjmd9COBy5x8xUhgQDkbY/vIfdGv/LmibfNgUPA5meShNWAkeLJ755+RmOYuYp2zBMI/ktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY3FKjgb/YoeIrUuIKW0TOhPbruKuygvzwU1nCqRyks=;
 b=HkLR8uY+nkfZLL2HfNqOmw922oeNmRJlCcxSY4VTT4bufwD1YzeM2xe1+MEMKUsUgT+eGRxRrIT3RFSRik//ooJGD+tKgozBzumOhUPlSvmiN34lQyz2vN0gaZ0FXe4gwr4WseO+OqEoaI5bORriWrOpZEG6jJKRBTlTkgkHuQGueJzoBGrxTbrB1Rbn2AiHKtZzxcc3u5ueXQLqH+GuDsX0clMUp8qb8DWWbQMJAkdu3mgIxj+nLe22WOdnBS+cyq3Vnupx09WoZWvGR/piPJf62RXRz2DwC5PmhJWWEYl2RxrDZ7DqQB4ZmgAbqMMv3hW6WOf++ytwsCAgwl+tzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY3FKjgb/YoeIrUuIKW0TOhPbruKuygvzwU1nCqRyks=;
 b=cydZVY1ZZb2QdIz8+5vesoly+mKUNukewoXlpCxYnbM1xX0hE7vuoehsyoxfZCRnQgd+EOcsCwZo+Qm+FC+yvtgrNfrZwdJA/okFg87BilX6E2zQmhqXIB9W9J2Oj+0tHj0V5uOl3B0UiAUVhltBxu+yI3VgTZet/dxoRUBNV8g=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3627.namprd11.prod.outlook.com (2603:10b6:5:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 06:06:13 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 06:06:13 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH] fpga: dfl: afu: Corrected error handling levels
Thread-Topic: [PATCH] fpga: dfl: afu: Corrected error handling levels
Thread-Index: AQHWKVq9Jcnvngz3AkiOgohHnshzdKim3E6AgAA7lpA=
Date:   Thu, 14 May 2020 06:06:13 +0000
Message-ID: <DM6PR11MB38193B495FB1DB4697F0094F85BC0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
 <20200514022935.GE29933@yilunxu-OptiPlex-7050>
In-Reply-To: <20200514022935.GE29933@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9258c4c2-9c30-44a3-9db4-08d7f7cce828
x-ms-traffictypediagnostic: DM6PR11MB3627:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3627AE8C6D1CD52B7CC2357885BC0@DM6PR11MB3627.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxV2CACWXf1mQGPl4A1tXK6yPTx4B2iba2UuHmKEpZE5WjO8+uQz3Ik43mnvatnO3OD/3FiYGv1zY7kmtIql0LR6d5t1+ZKhLDpgjtdSScaHhKyZulr2giwTsZf91knUJvoaIEbpOoWd1lAtVLLNe+PQLfczYWlfHZsyxHM7juZc2PzrK6WB6Yp2ujrFppO0i4Zb6gugAvI04toWsWEDViH0JNWcrRucnqq1OjbE5XkN6d6fUlouN3I1ux14nfnOks/W/tjrtqKVGdO0WlqaXPrrV6b5qlazq+PWSQgJN1Y8hgwouoJETlOtWCqaKg2GNIxKUqBlR1V/JneI1M0ePZWLAy0ltrAUbExgQJPs8XQYARfSwkzm6qRaXjh+NvIQPQ/CIMf4v2ikr2VDx+Ngw6ymKjlIh+KTNXbguTWhrcl2jnMSX+sfpi492t/Xf2BH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(346002)(376002)(396003)(136003)(8936002)(33656002)(478600001)(186003)(107886003)(4326008)(26005)(6916009)(66476007)(52536014)(71200400001)(9686003)(55016002)(7696005)(53546011)(66446008)(64756008)(6506007)(54906003)(2906002)(316002)(76116006)(66946007)(66556008)(5660300002)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vykd7C68Skrjz2om6hY1sG8QwDxn924VZZ248gWAFPTVm5kTwExUK9fyGCKioeZ2Ryx4FpwbAre73DCflrcCspke3fgurQpqfBB3ZhIpbxtu6WSlCLGzfO1yEFMH3ZHO0vw5jO2fRkrNEglpRvLvm/YMWduUYSfeFmKDZpzpXvrnboj/7kAqf2BBLNEiDbUzczU6D5vW8KwytOLcB5Ecv8rfn4Zr4+0ZKujLWJE0LFKNt08LtqrXdIwHz6ZRDTZClHKwBGGEgqjNifBcIzjKUeiK9iNHP8htQBWiBzLSSJKMHA3lcbftssXFv30AGvU5qeUCYK0HVNQpjOwnRh58lRIK+3VRy4FroW9PPcmr05oWo2k9obovAg4ZZrQiAGELKlCLw2EAcW928bV79w9G7PQJXiBSJMdtCqmb5SRPT6G3bRa0SgF9rV4rO811puD8sTIQ+BEiHlSpwmg2T/tOyuouxGTgNj//FzetQXRRiB8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9258c4c2-9c30-44a3-9db4-08d7f7cce828
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 06:06:13.5260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAqGcX9yhxbq5CKWeKOAMoJbM95UA+eUo0Mnl38Qz+ZuzBdcsGTM2ybAsG0wUQRVR/ymkYsYkmYS4ne8nNwj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3627
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Thursday, May 14, 2020 10:30 AM
> To: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
>=20
> The patch looks good to me.
>=20
> Maybe we could add the Fixes tag:
>   Fixes: fa8dda1edef9 (fpga: dfl: afu: add
> DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support)

Thanks for catching this problem.

With this line,
Acked-by: Wu Hao <hao.wu@intel.com>

Thanks!
Hao

>=20
> Thanks,
> Yilun
>=20
> On Thu, May 14, 2020 at 12:52:05AM +0530, Souptick Joarder wrote:
> > Corrected error handling goto sequnece. Level put_pages should
> > be called when pinned pages >=3D 0 && pinned !=3D npages. Level
> > free_pages should be called when pinned pages < 0.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/fpga/dfl-afu-dma-region.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-d=
ma-
> region.c
> > index 62f9244..5942343 100644
> > --- a/drivers/fpga/dfl-afu-dma-region.c
> > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > @@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct
> dfl_feature_platform_data *pdata,
> >  				     region->pages);
> >  	if (pinned < 0) {
> >  		ret =3D pinned;
> > -		goto put_pages;
> > +		goto free_pages;
> >  	} else if (pinned !=3D npages) {
> >  		ret =3D -EFAULT;
> > -		goto free_pages;
> > +		goto put_pages;
> >  	}
> >
> >  	dev_dbg(dev, "%d pages pinned\n", pinned);
> > --
> > 1.9.1
