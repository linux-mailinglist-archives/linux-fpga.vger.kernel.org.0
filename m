Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23451B7EC
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 08:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiEEG0f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiEEG0e (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 02:26:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1EC20181;
        Wed,  4 May 2022 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651731776; x=1683267776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g1V/kiqXAVGQBSWcoZuz47rqvZIcbz4nDMllcgxW5gs=;
  b=OyMqji6Hh1168DliUfQaN9R0f4GxHIkIHOhobpf7ItcLHTra9f+OhFVo
   FIKn5WAjVcQu9yfzXr5nctsHIHSLMX59Ph98z56/18YJL90pqBGTpkWmc
   3xISrE1pn/FXOe/ovsajGDzW1E6GJVJZEXaRqZIN6FGYEQGzupTz9aBdY
   iiPNq9Wdg3+KjVy4qw6652de1HGLKotLSG0syd9X2E53uHm6XxK3sKHdo
   ZQFj56enVEK93cPtb2flFjU6M7qzc34Y9nmO9Pk+Xr3Cz5KuaRJyFH7u/
   61OhwAHkBKzj90zc2DwOb/JYxBDTcSBLSKIKE1oz1F7GxF9wm8jfK/gTz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255485575"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="255485575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="708797612"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 23:22:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 23:22:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 4 May 2022 23:22:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 4 May 2022 23:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx7G+APc74hoMkcMYBPL6H3ImbVybBGFDB3rZJdp0RHm0EuQTOOaWPLJMYvlLylrggbVU3DFP7O0U5ZLp63Hn15KIBmT4Tqzux55o20ykaZKJh+OgmWvDlweFDX0Q7uAfCFPIvlPl4jjTwOje+Yn7C6oww47DmD0hXm/i8ZDjxcNNdU51TFuIdthD7MvHz/Z08tCLho4iSc74mFXeeor5/opUeKGTAsC1yFIicKEZRxr7CZrbeaWaY8SkqwW20SNawaJ9JKDzGgCz1YNIoPFue3Vf9fw4f/SImLqjcvTJGRYBKtO+1Tk+EiFKsMcoTC9il70S9Ppkv79m0m4QVjerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d65588aL3xPGq3MlVVWvNXENfhPYnqrvQYAAOYfo/Zc=;
 b=Lr+SJrEdp+LdDDwEZhzEgPxymCWxBujeMR9opcXOsccpxDiv35rd3s+9jg3uFj1bQy6CQpaq55sDmdNVckx6lLt29VBLaMDtUZiY6acrYekae5R9yW4l1BZaEQr4PFyXI2E0a/2PNdaunmJb7JtThKmk27AAeOqb+sQYCcLySoHrCdnav0wZ/Dpc28sInILLeBD1YbNKr2t7FLi/n8fQGQ+lYwAYpiVYn73+gK7xg5nIRsvc3tQh3rui8QSjYobwZpp4O7LdH0htpl7tqBbgodZd52qORrpE9EqoreSIRNPZxP2oxuDQvp9WoRx3syh7Xqhos4zXJbzbLsqQcbOHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3115.namprd11.prod.outlook.com (2603:10b6:5:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 5 May
 2022 06:22:52 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 06:22:52 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Gerlach" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3] uio: dfl: add HSSI subsystem feature id
Thread-Topic: [PATCH v3] uio: dfl: add HSSI subsystem feature id
Thread-Index: AQHYW8QF95l1sPEw0kGUK+Mpk2/8L60IhJQAgAAIaICAACKZgIAHKTJg
Date:   Thu, 5 May 2022 06:22:52 +0000
Message-ID: <DM6PR11MB3819577AF82DE95DDF12DE2D85C29@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220429005726.607804-1-tianfei.zhang@intel.com>
 <b3f0bc47-70ea-2da5-2891-3b01550c6da6@redhat.com>
 <20220430142452.GB398931@yilunxu-OptiPlex-7050>
 <774dee52-7f68-9d50-4a61-feaedd99eb86@redhat.com>
 <20220430165847.GD398931@yilunxu-OptiPlex-7050>
In-Reply-To: <20220430165847.GD398931@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 6ef9c5a0-c4ae-4d4c-5b76-08da2e5faf3a
x-ms-traffictypediagnostic: DM6PR11MB3115:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB311534212E8DB2A9C0F7183E85C29@DM6PR11MB3115.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IErouLhx/hKFFOm1huW2H5vdORsckJ9f1kxm13DtWzr6yqHBlf2T25NjZbPiRzu+PBR73PweTZDm9g5e37HbSwp6HEd0atKBzWdT1nLnHM0pvPDM9nGK04ChZ4sqMjmvjYAcr4BgdzUwPKQX8IQoc/o/Sti4L0Z9kDXi6apMVHcV2vVp9sJ5Uq4h/LqwVkKCX89sAWEKVwTUYUk3PO5an3z+0X+Q34g6zBnm3lblSG6g7LysYr0EgdhT9LFG3Qz1S78bVGuV2UJylTtJdLsYQkAzvNofBCeyqS3SlJokKsZM1wnFftX1y8xLTkT7jqKdTzkx9UwoEOtgE5vgNKIrk8TXTxjLVKg08gZ/krs2DdhB5EUZyN0w8ZptP0zrwbPKdErHVTAa1EGxCHbG8+3puKfNJpon+Xvkd4mzgKEqGzyxIttpDBZnM+SJ2DQ27/0dLNiJrwQQfe4FQl7Yw6kHI4xQLxVKwJEsCI2DrKh4rf3WR91yOAOcTtg/ZfkP1yFg64tQTUNGgsNfTf0/kVfsk/ZTCzL1+hH/ti0Fgg7oDwq672xTRd9lvEIi169ULldgbhYXjfkKjUv02mqxW08PXNyPlGgl0c3NpKc9Uk0JLsvkz83drKJCWdL10itgbgwYDJkqZ3CJHEwzlNapqo4ij7+IiEundLA/5FaRsF4J/6p0Nw0SVZqi35MCIes874y8Lt6jxMAuiPibAHzdLFuywOKNBtg9og+BdzGlS9IlySodhL3iTS5zLnpWfWtLituqLP2c2nKfI7Vs08zC0WEQKATgGQ0dw3twFwG2QUKSNQhEgyXcQqYShJYMUZj1UjAlCGtvDD2SQOs2GJGghmIxpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(66476007)(76116006)(53546011)(71200400001)(8676002)(7696005)(66946007)(9686003)(26005)(86362001)(64756008)(4326008)(6506007)(122000001)(82960400001)(8936002)(110136005)(55016003)(38070700005)(5660300002)(54906003)(38100700002)(966005)(33656002)(83380400001)(508600001)(52536014)(186003)(2906002)(45080400002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dOFtMDUZim7cfX2lQqe0SJra+75KaCOS8r4sOLqQ/n+5LnrSISQPKrhGL1X4?=
 =?us-ascii?Q?Cw94q1nh4zgqPQToOg7OQPU2fvaz6nxjgkFZedwL3dt+H0Y71gMp7ni/uBvx?=
 =?us-ascii?Q?RgP8Ul0PU2OQAXkbsfy5mvh89FVCK70HWoZmu512sznSuhygZKuBEHR9mIog?=
 =?us-ascii?Q?6OKNoC0hr9he5NwBrURhucwJbxbw41c4w51KMRpwK9YgiXRxfuI4K5Fy6mHz?=
 =?us-ascii?Q?+frfo6Tep52VK7/+BGn4KlHtS711DH7iXL708vtldfKAsqPsWmzGA21fGj/i?=
 =?us-ascii?Q?nveqyOCxTyxpKIKcVPgjX4qAZ/XRqm4kuXUz/ey4/YriyoV/cKvd9Ww9NKLW?=
 =?us-ascii?Q?91G7sYNXdlDx8Zi+sJWcz6pshWt/+CI0mBptE6XZ9Ta+UVjrlUcwwTU7QejS?=
 =?us-ascii?Q?jWK0F6ZPf6gyUKwfnmQqnO5s7FHWN+hP8AS2J+o+01U+ZKBCoH8PABySqLMl?=
 =?us-ascii?Q?JtWupVLd6u9aAR7Bt+UPzfKMJE27KGcsqC4xJM6tsofqbqnqx3lECnFZQWd4?=
 =?us-ascii?Q?shHQR/qapQn7d94/8vA/woPnxmS6tdqB2Satf6K/yf91iU4yAVNgqkYaR1Cj?=
 =?us-ascii?Q?IM+pmDNo7a1hOSYvg8vVA6iONVLfwnr+xKfZRI0nvSNVu77aVFgycByRbV4y?=
 =?us-ascii?Q?5ml4Vklu3BQqF363qD6V5hLZxUTYEHd/EIsNLySA1SYB/SQteJa7mZis8ud5?=
 =?us-ascii?Q?ukwx7n3SN8VRQwBZbOraIsEuL1puVuwCDhdLOf2BhmAsQY3kXmfw0nDTiMZp?=
 =?us-ascii?Q?jAXnC4f4OHaQy2s/8LWIlexjjfUzHEcLomPpEdCKabk3wQpmyF9GTK5b07fY?=
 =?us-ascii?Q?brWeklB8tKU7sijOo1iwlIrt14PrPfcPffB0TYhMQIF0w/yhuX5xD+B4ViZ6?=
 =?us-ascii?Q?TiQ6V3onQIF0QbwWhD1xY3TfsUgd52pNv0YB8s2y+Ap02R081qkR0WxDGdKd?=
 =?us-ascii?Q?S6kVk+0Eplf7B9fjipInwpVdfkXqhT7GRUfptc4tOmqLiO7sY0bC2mOyRSau?=
 =?us-ascii?Q?xxhzbXnaT4J0jXRmvnAa6TkY6OIKVZLa5Nlq8pEGx5OvUj9mniv5JwPV48pH?=
 =?us-ascii?Q?475GwBz+ZwoEh3f2cV3czlFOqDEE8YZRSyGu6dDFCGGzjEEhWNMAj+ey2D+e?=
 =?us-ascii?Q?uZFLJsxzCJAA2yWVBMJzI9Nv549RImfUPFd4/2mxuStdqAwN/yA9isILyIky?=
 =?us-ascii?Q?F7bNGRJu0kHdOOr5CX3d2M2uTiqdnT7kGZz3/zttWEy8i7j2MG0uQJ4P3Zqb?=
 =?us-ascii?Q?pzr2Bsipw+1Nl6jHUv8e62gBsC03uAiopsoHrnmpiKJOd/JdwaNYQHV4/zYe?=
 =?us-ascii?Q?4IqOS3xvh0BULT4QTGEx2WyrOnLV2nWKpvhkLXRp9pDT9rYFPVHMvL0d9jeP?=
 =?us-ascii?Q?zh9e6Se0A6sXKtalmsNCipK7i8OSFbA5US687+4CJhtfL6kEj2/mI78DgWrK?=
 =?us-ascii?Q?1oRoUmRoGUd/kjMK7kIx21O4reeK1v1gCbj1dZckHN/sWIIEhMXrLaKFoa9W?=
 =?us-ascii?Q?6E1sUKpOVEt/OpagiURmu6j9mPvbw+pPVtvaHIPz6hlP/naaj3wlARLiWN5M?=
 =?us-ascii?Q?lDj+cJjHJ52XxmOLHYO2zDaUVHzBb8i51TYlrvh14T6yUL7O6A3NazjPRw8H?=
 =?us-ascii?Q?avSQJYDQ+5xn+vXPYWidufDRqsi+8diz7V2YOETF2evS8LI+I9UiD8cVasBc?=
 =?us-ascii?Q?fArRyRXylUwTrZymS+t9T1Z2D5YiqoMlbQCzJm4uy6FeJctdScK6OTf7425I?=
 =?us-ascii?Q?V2HIjBxOWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef9c5a0-c4ae-4d4c-5b76-08da2e5faf3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 06:22:52.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzjA1oCjbpECLby+iMe2XFutqgSV6v55Sbo8rc+FWOURrV5iBZanRGOGRwOJx5CR3i67kU38Ki+uQPloaaE9/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3115
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Sat, Apr 30, 2022 at 07:54:57AM -0700, Tom Rix wrote:
> >
> > On 4/30/22 7:24 AM, Xu Yilun wrote:
> > > On Fri, Apr 29, 2022 at 05:23:53AM -0700, Tom Rix wrote:
> > > > On 4/28/22 5:57 PM, Tianfei Zhang wrote:
> > > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > >
> > > > > Add the Device Feature List (DFL) feature id for the
> > > > > High Speed Serial Interface (HSSI) Subsystem to the
> > > > > table of ids supported by the uio_dfl driver.
> > > > >
> > > > > The HSSI Subsystem is a configurable set of IP blocks
> > > > > to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
> > > > > Like the Ethernet group used by the N3000 card, the HSSI
> > > > > Subsystem does not fully implement a network device from
> > > > > a Linux netdev perspective and is controlled and monitored
> > > > > from user space software via the uio interface.
> > > > Generally you should include the url for the dfl definitions.
> > > >
> > > > Can you add it here to the commit log ?
> > > Do you refer to this url, https://github.com/OPAE/dfl-feature-id ?
> >
> > Yes, exactly.
> >
> > To someone not working the day-to-day working dfl they will have no clu=
e
> > where the fids come from.
> >
> > When a new one is added to the kernel, it should have a listing in
> > dfl-feature-id repo.
> >
> > If it doesn't, there will be a future conflict.
>=20
> I remember a recent patch records the url in Documentation/fpga/dfl.rst.
> Anyway I'm OK with or without the url in commit message.
>=20

Yes, it's better that people can find that in Documentation instead of some
commit message. That's another patch from Tianfei.

Thanks
Hao

> Thanks,
> Yilun
>=20
> >
> > Tom
> >
> > >
> > > Hao has some comments about this at
> > >
> > >
> https://lore.kernel.org/all/DM6PR11MB38190E6EEF6DE3EB900290C585F39@D
> M6PR11MB3819.namprd11.prod.outlook.com/
> > >
> > > > Otherwise fine.
> > > >
> > > > Reviewed-by: Tom Rix <trix@redhat.com>
> > > >
> > > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > This patch is now good to me.
> > >
> > > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > >
> > > > > ---
> > > > > v3: change the name of this feature id to HSSI_SUBSYS and rewrite
> > > > >       the git message.
> > > > > v2: add HSSI introduction and the git repo of Feature ID table.
> > > > > ---
> > > > >    drivers/uio/uio_dfl.c | 2 ++
> > > > >    1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> > > > > index 89c0fc7b0cbc..8f39cc8bb034 100644
> > > > > --- a/drivers/uio/uio_dfl.c
> > > > > +++ b/drivers/uio/uio_dfl.c
> > > > > @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *dd=
ev)
> > > > >    }
> > > > >    #define FME_FEATURE_ID_ETH_GROUP	0x10
> > > > > +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
> > > > >    static const struct dfl_device_id uio_dfl_ids[] =3D {
> > > > >    	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> > > > > +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
> > > > >    	{ }
> > > > >    };
> > > > >    MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
