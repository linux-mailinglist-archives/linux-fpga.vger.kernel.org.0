Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEBD504A69
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiDRBXc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiDRBXb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:23:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA56DE5;
        Sun, 17 Apr 2022 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650244853; x=1681780853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/FwbTpt2IIiZPLnON8F0eNoz/tqgbZH/2/ujEj5/4+Q=;
  b=Xq0G/2GOLSV/XyW4f3464HqqNOokK2QCWxp2U3MfXhPuvTysUH0YHri6
   6/kis1dmmMzZcNNBnqPDL+T0LCAmQiQGWYBbhq/mlPAmTjgmznPrsHS27
   Dt89XP8POiHiP+Kk1GbMfa/izgH/qYcFyl8HjjeGL29WAbT0lcFaCqlxP
   rYoTcKp0MVYWaDQxaQHRjJZDh39QsaP5hEVlOhKqcormqjimKT9GHPx2L
   mQtA3ryoKZzj4PjIm0xveDwYYV3qzLeb7aHnhaApou2v5brzmoui0lJ64
   ugGoOlVFybyXd+9f6nzKgy+cQI6h/g71zRIVb1qGadEjL2Vxd5KD9gnF0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="250731009"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="250731009"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="575357215"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2022 18:20:52 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:20:52 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:20:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:20:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubn6daE+Vsnz8HXwae32AZxU2gxARC+kfkGJvowiYxv2L0NLU3oSryMjl+cG6VJplNQaxVr1j6eiz3A69MgKL13tyC/gBfPabUAV4sJ6GizYpOc6nEYvU+QyWDZH5BhFTmCU4GswGpSEsh5VaP8Qp8lVohX0kpihdk7T8JvGdFZKAWiYDiKSP8Y/Wv+fBe8BA1lPrkgfb0KbpOwq3o0UmWs/aSlco8MocoxoNzErm5aObd99uH6RdL0BwCHKtC3XAfsT1i2XU2aZoQ/BW+fO/idQWK5bMFEwsCdti+WSbpnUl1E4dGnKs1KLD40yng/KAKhs2L+w+UZd1NBVkVPnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FwbTpt2IIiZPLnON8F0eNoz/tqgbZH/2/ujEj5/4+Q=;
 b=MgslRZdw3YUFpcr8l5HTgMiOeB1NUPyluO1to5hzFhR6pOfMtGhWCQDNSFTCjQ2sP1Bxj6XD02colGElQ70lR3Fg1V4TIR7T54Qz+aLY227Rws+1Va1AhAwa1xldV8KOtAQsjbdhOGYLvHHkXP+Qt+5UPKftxkLBNcuXLDboEKzwBKZtQtSn3xzseuovkJwYRfQ6T8ITDUi3xPy0YshcQeAcg5H0OuWbVYPaUcbYXIIxKRprkURH+u1QQN3LhvAsby7oQB+jAYZKFEGOF6NrUBtLVB11VK9m6PCqjMGB5ij5h8ZDr2amHRdON7BSaMUIJRmu/WknundBxxzDBmn9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB3432.namprd11.prod.outlook.com (2603:10b6:a03:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 01:20:49 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:20:49 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v6 2/2] Documentation: fpga: dfl: add description of
 feature ids
Thread-Topic: [PATCH v6 2/2] Documentation: fpga: dfl: add description of
 feature ids
Thread-Index: AQHYTjVutKxTmm6bI0y4u0mopCG2L6zscsCAgAhyUwCAAAMZ8A==
Date:   Mon, 18 Apr 2022 01:20:49 +0000
Message-ID: <BN9PR11MB548313B0FC2DD6908E79D408E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220412061705.53721-1-tianfei.zhang@intel.com>
 <20220412061705.53721-3-tianfei.zhang@intel.com>
 <alpine.DEB.2.22.394.2204120908150.278492@rhweight-WRK1>
 <DM6PR11MB3819201FF7ADAEEF1EA31FD285F39@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819201FF7ADAEEF1EA31FD285F39@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: db9507c5-6eb6-4791-f40d-08da20d9ac3d
x-ms-traffictypediagnostic: BYAPR11MB3432:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB34329A2413AD365DB265EF2EE3F39@BYAPR11MB3432.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ko+uCS2uMAlU7QryNwFDG+xoRuuflHaZUAXQylKkLD3GnufrzgHQrZk445OplqwSOraBf4vBJS60PiRKo7EqzY3ywdxG84J/rUStkvQGYM08698AeSi4958gAR5iJ3KaTUS6vCdYW4zoCU9CR4c/ZH7MtJLYwBryv8+jWMPV4hnW6JDUxhCm4JW1uMhvtdiq9HcX537TQXdnBeSKfe0oJ4yIyxBIQIb5FXqRYkbW5j8HwjwdqSQAllwlYXzZpFF9OkFhpuPu1MgIGWyTSiPW1ohO4WEo71Ndz5uOZzEItB+UiHIJsxqBMQ8qwtlAy082MlqPvb8lspNgWCnVP85W4bHir5jT7kiTlqGHoXmCgBI7CjwFwK2Oc3j8DRdvC81c6Au7NOR57uq5J6kP50EutXQDMx7MLKGLm+aW9eSbh7up/7eDdZiBszoJG+FtD5FIm6240ICCbpO27CwBatc1f9JjKiSYuLLvqYGvjpmWCurTRP6+hFnpZoL78u94q/Q6Jam2n256FjgGRq6hFwSOCYuU/RoNRhGJBPRJf2Q2317Wlt0xhyHo7wil8hKLTKEEnHPQPmpNJJFCapMlmvhmxNw/95g7k0DYc3yCTUkotMX9bHKeRLJ2tfgIZ5td9l+fCs3tDQTrWAzl2s8GEWESAssM0f9/NuVNpF8HfGFzfEh4/yi4Tf0lIaveLyqTz3X1l4WL3Hy6yrjeCyZ5xJ/xGqE5RpyGf89wtbf/cx0Os0NbHKpeY7l2ktHSaSq/Cyk0+fZ9eYIJg9OIJTs5ECQNEbMdvzhJnaDH4QjbIgnIyYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(55016003)(186003)(4326008)(8676002)(38070700005)(38100700002)(71200400001)(508600001)(26005)(66946007)(66476007)(66556008)(2906002)(66446008)(6506007)(76116006)(86362001)(64756008)(9686003)(53546011)(83380400001)(5660300002)(122000001)(52536014)(7696005)(54906003)(8936002)(33656002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0eGYttu5XoIqtC/eAtV291MKA8IgBOkkYWfURHzpERuCj+2Awn+/8EHadvox?=
 =?us-ascii?Q?5PkwkmFBtxxNgPlAHgeRUZBswEEA9BmGhMcnFSe8Sz59afs6hzAdhZiIe3z6?=
 =?us-ascii?Q?w15HybevCvqtbHwcOyuLlqTkotecKMY29TIg4SJmzVxFrxYsTpNPI0pip79C?=
 =?us-ascii?Q?wcb2zFKzMSg6T4HzRIPXrYyB9cR6gzEYZq7DY9BK+OCNdpkKFIrVNryNPBmd?=
 =?us-ascii?Q?WWCBxG5APk1Y+7VE/YS/VukLwsoGmjAYcwkGJ6hH0rEuL2sSYX/gQLzQZgIY?=
 =?us-ascii?Q?irGCrI829yY0iRkXxMjzDLBlxIiXLuW4OL9WX718gURAgx4gy1BWOTWiBMZY?=
 =?us-ascii?Q?nN8u6wYRRCD0GsYuHAWSBHQLj9XaleKCpO2+OLr7PwvVEYXw8j/+a4a0G6fq?=
 =?us-ascii?Q?gHf7znRwycVOvrvfeHrDTnozbRjbFMX9dwOz5Ocs+ZaquICB3/Cui5LlzjGx?=
 =?us-ascii?Q?QYeysVndVJgX9m8SVvOUfuLpy056E7jR3kR/1mNg9xfbM8eavyuTM4zs3WRF?=
 =?us-ascii?Q?p1TS28kIQbaEdaYMxYvOcFA4Pm/Z/kxRTgm5nt8Lsqj4V3X5OjKSG7yXceF1?=
 =?us-ascii?Q?MMIqyJpk9bCnhx+XbqE3YKKLPJLbm+E7z3dAkeb1F0laO6MBam5cv31LS6hD?=
 =?us-ascii?Q?RfWUhZXhmnqPZwG0bE8RUrmjBFRGfyqQVmjZih2twg+QBPQeS8lMWVXvTDyK?=
 =?us-ascii?Q?QihOxNqfuz4hoE/POjNisVLlpzXDc66LtqRgSuB2JEH9H75xE88yR9ZB3fl0?=
 =?us-ascii?Q?9X5zM61lQz44+5YXaXBUEJ+qpm4hxWiOu5jSlMh6Jv/J+setB4dJAMQlaaS+?=
 =?us-ascii?Q?JxfY4fvhWxz4kPVULHxZE4DTdtTYKKhY1Ez/MfJI+keeM09P+hQ8DQoFbmbv?=
 =?us-ascii?Q?+QIxJvyiZCBXYRRrYQsG3QK7cDvVb0V4UY/rdGdJb8jm/NrHxgZJsGwUGQAl?=
 =?us-ascii?Q?MHEcgkTJhFSgWdwEj3kAYTcrlmCt/ELDYo0cJoi9qXq96B9PsvNn51XHa8cB?=
 =?us-ascii?Q?2Xw4+2aTCo44Jx/XRUA90Mj1SmRc0SdFwVT+ToAVJ21ceCUUe03WVspWhvPw?=
 =?us-ascii?Q?gWpgXKRe44Y0u7CXHgWyO/aIa7LT2JHTP00rqPtXN4tib+bBkqfNGOldEXZe?=
 =?us-ascii?Q?uctXR7S0YZF7wfZn697dAxxcP7CscfvUwYi7gg5BBf82EtofSRaaC65EZnuh?=
 =?us-ascii?Q?QP2AeBGu1NYuf1TNyNQqTciP2GtNIve/Xo6jM7kt2ntqwZhayqgRXzIFLwUq?=
 =?us-ascii?Q?YIib6RQ3FK/DMVFg0oWEOvdgZ0EjwrsCF0BfqrCZG5I1495HRgdEBOz2AcfT?=
 =?us-ascii?Q?RGwhuG4B0kiAXGdAJUkjCaRqrmV55WA7Ui7BgKfBu09rls4JNkzyu3knPC3V?=
 =?us-ascii?Q?L+EpDWqJud3KwWNhn/x7rsIQ4zOrPDbLNwHHqxJgr2YdQJ+4/3kDP6KGbhiV?=
 =?us-ascii?Q?JmMBKBjUmYenEA++6AIR/9KDq4cmBo0WOly7EGzsfHQ+HxfnniHSYfebQAev?=
 =?us-ascii?Q?UJNEI8sQmJxDN/Rr5Ln4IPchTBV5OS/dscY4FIdekq+fHOqz4x+2SJ0FgteD?=
 =?us-ascii?Q?/4zsnAZW13kh/LlVuIW3P1ULPYqTYeKtKJBQ72+pExFugwMa8vTph4Izpz8V?=
 =?us-ascii?Q?CbxVrt1eTFWkqUtI/sKqvRDcNP23UEkRQhay8SChhvFis+RXg4JwUz1+GR23?=
 =?us-ascii?Q?+LO+3k1RW5zAXvIBVq8dv0Lu2FOagtavXQkQcOzDUdIogifU7AMBT6WpB7AC?=
 =?us-ascii?Q?QposrdUyjw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9507c5-6eb6-4791-f40d-08da20d9ac3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:20:49.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWo4P06k+Hw+JuzJRsa5jEjUUZ9sIAtrCKVjsEUi8/sT0j2igfXX8133iA6XBRV1mzqmqqUq/zU+ckG2q1iouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3432
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



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Monday, April 18, 2022 9:08 AM
> To: matthew.gerlach@linux.intel.com; Zhang, Tianfei
> <tianfei.zhang@intel.com>
> Cc: trix@redhat.com; mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linu=
x-
> fpga@vger.kernel.org; linux-doc@vger.kernel.org; rdunlap@infradead.org;
> corbet@lwn.net
> Subject: RE: [PATCH v6 2/2] Documentation: fpga: dfl: add description of =
feature
> ids
>=20
> > On Tue, 12 Apr 2022, Tianfei Zhang wrote:
> >
> > > From: Tianfei zhang <tianfei.zhang@intel.com>
> > >
> > > This patch adds the description of feature id table in documentation.
>=20
> Please fix the title and commit message per your current modification as =
well.

How about this tile and commit message:
Title: Documentation: fpga: dfl: add link address of feature id table

This patch adds the link address of feature id table in documentation.

>=20
> > >
> > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > Hi Tianfei,
> >
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > > v6: fix documentation from Hao's comment.
> > > v5: fix documentation from Matthew's comment.
> > > ---
> > > Documentation/fpga/dfl.rst | 5 +++++
> > > 1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > > index ef9eec71f6f3..15b670926084 100644
> > > --- a/Documentation/fpga/dfl.rst
> > > +++ b/Documentation/fpga/dfl.rst
> > > @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature
> > > driver
> > with matched feature id.
> > > FME Partial Reconfiguration Sub Feature driver (see
> > > drivers/fpga/dfl-fme-pr.c) could be a reference.
> > >
> > > +Please refer to below link to existing feature id table and guide
> > > +for new
> > feature
> > > +ids application.
> > > +https://github.com/OPAE/dfl-feature-id
> > > +
> > > +
> > > Location of DFLs on a PCI Device
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > The original method for finding a DFL on a PCI device assumed the
> > > start of the
> > > --
> > > 2.26.2
> > >
> > >
