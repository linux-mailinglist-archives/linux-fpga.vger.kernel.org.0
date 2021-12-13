Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839684720FC
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Dec 2021 07:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhLMGMn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Dec 2021 01:12:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:55885 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhLMGMm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Dec 2021 01:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639375962; x=1670911962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wgbxU7JPJmVexmbY1zOGROhoQQlDa1/RSFmyiImMe9w=;
  b=RgiiEF8VJ5gV0RrVGNBx6rOBARr6ljNsmXIy6nZz7ZTiem9bftwhKfJ5
   IJ7u3uawCKnyu0inrIFyWYYlo5I469VrJWNR8JDAmv/9VUnFAnOm1WjSd
   qjTEo/T9fYK0Tzkj1XHa4E6anE4ioCFWz7evdf8YrN1tu2dKttCl4sR6k
   4hCGtbt69elYuWMVhMLRmWhmofEZAOglmP8Klx82YlJnlCQR44C7THC76
   aeYYN4B65YDEZr1Hzr2k/scefqLpB6gO8aDMwxEZ9uWaJwHZJyXnY6BKd
   de/aSv4rkvBzzGQdDApbcSqfJ6ENnaB/MbzwJEgDxf5wKTaBfesAp3bAF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="225530021"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="225530021"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 22:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="544665972"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2021 22:12:42 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 12 Dec 2021 22:12:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 12 Dec 2021 22:12:41 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 12 Dec 2021 22:12:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI1PZK/wXHrMYtS89JPh0UFLuTSCMwYc7778Q1N1Nxn0zYfbT5XsCKA8Mr0se+ZaJvl5Pul70OPTz60DPMgMJd4qTLpAzQg80uCYWm/2UCy+DR7c0U4T0d9tQALaYCxDQQ0zMkjw2iCLe9R09TZ5WuAZPKx6M/Vjbq/kAcPs9Ll9pxk4/btCDjXJelYVpQjXYb57noCfIMOmw5oHVsyDwTk2vagOpUUeLOyBTWZjRiJ9KmLIMczGyzhNduagldsoEkQKS8DLewUfw9vL7Aj1L9RmTm7w78gYqpQTltRz2sD0rVLpbW/RLE1V0m+UZoxUlEh1GaYBCzs6eh3dXJb5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdaZS1RGc70s5XGP96bQ11W2akW4xXknPul5A4C9i1s=;
 b=HGNxjIecMkXcbwMkhlNwJb8S9XkeCXiFq3bSoJOSXfmoSZk8D6vfy6bCsnvDEH5j4HFomJFA59S9rzi8EKw/YGGrcQI69sr+i0dZMr4wPDYC4+idxAeyuRPR698fVHcdFwMWpT+pZK54H55/nmnd8sYUX4/i/dM6YM55Vc/BT7FvBDdVuRDG+xVcYMSsDXDA+lSfkqRXt7l/n4UVmqPul8gJELXw73Ng2wROiBmNzhHVUeA8w808bveV44KUP4u28pIKlrcTSmxdUs84HnKJ5cXLDIwKO3idM3hICgCAFQ/DBjJ/qW0G82eLi9TKlf+UaoWzy1m8Tebk//hYk0gzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdaZS1RGc70s5XGP96bQ11W2akW4xXknPul5A4C9i1s=;
 b=Y3NO4JmNu/BaVwGWrP33MTykxA50uwbGbbDZNDW6II8jL1zfxKHKTBphDdZxJer9/yyjzsrnvkaqZSwoRz20LdV+7DoT35FldTBfX7ETBEn0vB2M/yjdMsL2OsRr/Bkfn4OYK2hfaTbuJxqJW3NZTykxepEANsjf1wT/QlERHiw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2649.namprd11.prod.outlook.com (2603:10b6:5:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 06:12:38 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d0c1:77a5:72d:fb9f]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d0c1:77a5:72d:fb9f%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 06:12:38 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Miaoqian Lin <linmq006@gmail.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>
Subject: RE: [PATCH v2] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
Thread-Topic: [PATCH v2] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
Thread-Index: AQHX7p5/xsSLfKUU10O4avfyee3PtawtYbKAgAJCegCAAEgu8A==
Date:   Mon, 13 Dec 2021 06:12:38 +0000
Message-ID: <DM6PR11MB3819B3918DA4D58E59228CAC85749@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
 <20211211145038.31612-1-linmq006@gmail.com>
 <97789bcc-0e5b-a822-854f-15d0fbe47844@redhat.com>
 <20211213012818.GC336280@yilunxu-OptiPlex-7050>
In-Reply-To: <20211213012818.GC336280@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41a4fe12-04a8-499f-0e2f-08d9bdff9036
x-ms-traffictypediagnostic: DM6PR11MB2649:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB2649027798A7FB7E255AB33F85749@DM6PR11MB2649.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWGl5rMDPURh38gwXYoKLUOUAdLEHCFEXmoUr0LypaSDGqTdK2D+ItIqN/NCZ40ukmWlPEMJzioOJ3kCMBWb+MtOs3SnYzcBlh99ZWM6SsG6zHZyJBpwhtbs3POXsepixWkkMsX2z9RX2PE0SXa089NqQZu3Jq70ecW9T6EvHGwjxihKc39AapfsmoMicD4XaCmHDYJeFO8mBkedr7M6j7DOYp2woCSumadmjOn0efynI905C/5c0JbVJrjck3danbDoxnjtflLwU2Xkc2vCCONYqW9ahxzxv1fCwsdhOAXbQfTSYgiNe3chpqy7MF+dX8XZAFpygw31/OsmUK28Ke9uVkDfZpeUkvOFWygPs/0XfC8m/HzfwZ3iOJ/9kVHKrnd1a4pKS/tsyDUR7s2Eqb2N2VXFxvxzd7ebQ2ECkE/wY3mdiqTYib0LDQRfQ6gD0rPoKi640XGqGS/9uRn0ym9yMr7NI9gEuQThcTYMk+KrElg1aW/Jm4yb4HzNbPGV1uIdSF4ZJcDDmkvPa8AFN4Z8irU6CEkRM0D46R1tZIWN08l2czXbfJJraL7IeWdj5apVOxUK7kRHVtX9K2q2sfrCu/FwrOs9TuefYNY6kGDumh1j5a6HdI/96xJjZflAzuSp2fsCrX6DCP75viRpofPxZFtQavrVc2gcK+Czy+HzIvxIpVdcK+8dhLbW9NA2XgZZmaDrDkPdv6ecTkGHvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(82960400001)(316002)(2906002)(110136005)(64756008)(86362001)(186003)(55016003)(71200400001)(8676002)(9686003)(8936002)(76116006)(52536014)(54906003)(4326008)(53546011)(6506007)(7696005)(66476007)(122000001)(26005)(38100700002)(33656002)(83380400001)(508600001)(66556008)(66446008)(38070700005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d8x5e0ZONhWdH9Z8X4qEmchv0uw5a7wPmtKFE8lyfppsBxxQwYGhbSq3NcYk?=
 =?us-ascii?Q?j8Aj5ifUWlT3FZ4gEoQx6OpCrzxVrReoR4/f4BhCcw+yazn4JxElkUT4nF2s?=
 =?us-ascii?Q?s0fLyt4dTlfSWRxljQ6mNBRAmNsplNuMF7F8WzXYzBLDxytW2d4XSAebfqw9?=
 =?us-ascii?Q?ETDy3To+bmtfkmChfZ+Xnx8TxafWJKT002nwtreYZNEaTNgHgieBYejyh77t?=
 =?us-ascii?Q?krfpFTg/Qo9QJBnjJmOGu7K9lXThtnl9Jp2M6jtFhnIoZp/qxJe5veQRi+Fe?=
 =?us-ascii?Q?Eno8UfK7jpEUM76ySopBZL6ky1dq9gCWjVeCxTwf31H0TDBs5SC2h1yjJNOS?=
 =?us-ascii?Q?fyKxUTMr7fNw0fH2qlUPaEjtBx0zbmPOj1SS3XTEXlJuMKCtOAf+1OHz5foC?=
 =?us-ascii?Q?bXLOqEBbeqgYRSMbhwc3Bq1XMxV0Kc8H9UK4CQ9QRWA9HiPikcSdYYB658hO?=
 =?us-ascii?Q?bTOkgrKlWboS6YgRS4VfEczDuU9TPTGq7GOpfUHQmmSUkio8zkCZA5Y07igm?=
 =?us-ascii?Q?DY0d7/DCSD5V7QeA8EOYB2l6cXXiLnnwUl6X0KlwSioLeU3hImHuQut4aDrk?=
 =?us-ascii?Q?lptnegrKnuERh+358fx8wYn8oaudRWH2b0QTlGOd0xwjd76+mzYyYfXoOpAW?=
 =?us-ascii?Q?AjnPpDb+O0gCddzuVqqH7+EoLQYl07c1fB2S2gLpbK4Z+bEg2TBTF91CmPU6?=
 =?us-ascii?Q?KwXXAb427TWBNCfDy8IiYIm98pcctXvQ4bjwndTooIMlgrqsU+5E5zg02DIa?=
 =?us-ascii?Q?encBBR+mDW+KOboz+sZiZ59SqfQE3VEeQiILsrSbDHdNmOGUVxwItjHjC4Zh?=
 =?us-ascii?Q?iWXbS6lfuLzloYESrbCfFLIWrf6UFynu6AhxH2svHGCCduJI5+HreCSjRS2x?=
 =?us-ascii?Q?KV8q37opEzlBiFqkRiNPZu+DyFuzpPm10wlRnZxfshPJ41c62fIEXi8HyXra?=
 =?us-ascii?Q?Nl3Jq0gNBiAoibAwTooAEzZAkh9WvAC1m6oJ3vSz5P4cxjjLGqz2CIkrcQod?=
 =?us-ascii?Q?pKGN9ss4ePIs7H2E7c7aLV/JhULCffsxGxd9qXLv4CofR7gJfSqXIg1n23YC?=
 =?us-ascii?Q?GJ1JBfqs9vIWPUACN9763/tbL7k8tcmdT507CQOFvtJlDrEfKltf5JfJzYdv?=
 =?us-ascii?Q?VVvC+3WukrlIf8ctli12xvcejIMSUttMhL4WieH0IvrWMYvdl9kGjnQGGRMU?=
 =?us-ascii?Q?A/Tm+k5sP00tPQpuSBcjMzwfdTxKnNz36sDEACpwQi2xFGS2VDMD+bz3Zx9s?=
 =?us-ascii?Q?JTTScFR1S9QfHVEx6ru+Qg8u1+b6f5UV2poe9qKDvDA9/dvmee/juvUwm+43?=
 =?us-ascii?Q?W/j5Vucdiosh2OhO/CLqoSyBbwTGykHs95sfiEWEvOSuQ5CW+/yA+C1tH2y+?=
 =?us-ascii?Q?iFZnrSw9RDCGPQn+ZG/SL0ppn19RoRFGx76sYhpLknONtgkbqDd5S7+uA9f/?=
 =?us-ascii?Q?GhbxjPG9pEBBLLxOWPx2nsm1V+BCHlZWtFj5xJPlbDtLDp8M2uNPp6dvszLg?=
 =?us-ascii?Q?LuzuJlb+A14xOzkFGrMdpN28R1Tgj9QyPqG5Et9qpUpN3zZbPCdeTQGJHhVn?=
 =?us-ascii?Q?Vzg+oFnIeeWe3vaTCGQxVLNXB5qRvEGSHwoU2VW/TVcbK0VMFpd9omHAKlI/?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a4fe12-04a8-499f-0e2f-08d9bdff9036
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 06:12:38.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ls7LOT+Bfgpm5SNlhhx6r71a9qCsUYhG6IOJNaDBtPEPu6GeWh+XgOUVxFuExjT4NR5GUT7Sp9qxL6e/HaxaDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2649
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > On 12/11/21 6:50 AM, Miaoqian Lin wrote:
> > > The stratix10_svc_allocate_memory function does not return NULL. It
> > > returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.
> > >

Please add "Fixes" tag, then
Acked-by: Wu Hao <hao.wu@intel.com>

Thanks for the patch.
Hao

> > > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > > ---
> > >   drivers/fpga/stratix10-soc.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-so=
c.c
> > > index 047fd7f23706..91212bab5871 100644
> > > --- a/drivers/fpga/stratix10-soc.c
> > > +++ b/drivers/fpga/stratix10-soc.c
> > > @@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager
> *mgr,
> > >   	/* Allocate buffers from the service layer's pool. */
> > >   	for (i =3D 0; i < NUM_SVC_BUFS; i++) {
> > >   		kbuf =3D stratix10_svc_allocate_memory(priv->chan,
> SVC_BUF_SIZE);
> > > -		if (!kbuf) {
> > > +		if (IS_ERR(kbuf)) {
> > >   			s10_free_buffers(mgr);
> > > -			ret =3D -ENOMEM;
> > > +			ret =3D PTR_ERR(kbuf);
> >
> > Thanks!
> >
> > Reviewed-by: Tom Rix <trix@redhat.com>
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20
> Thanks,
> Yilun
>=20
> >
> > >   			goto init_done;
> > >   		}
