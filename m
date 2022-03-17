Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D904DC231
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 10:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiCQJBM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiCQJBL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 05:01:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56012BF02E;
        Thu, 17 Mar 2022 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647507595; x=1679043595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+RCQdWu9jlGSUgyAV0d8pIHUutQ36xenA7XYSksK1s4=;
  b=MDXvwtgtOlDfDFGCu0njJ5C++N/b6taMKbIGbINuukeYeQ5o08t/KMPZ
   X0zrPO4UG5hO0Gy9F1V+QIGaxSs4Sd9RiX3PcmAKQuJxeQjhmB2ozFHu2
   t6DklMdWWbet6kUNikzs8nVr7/fkBr1rjFUVZiNrtKTwD7pg2rVX0Vp/7
   oF13gbai+UfDSVD8iVHVBYkw8YAFoS6mS2qAvOm5CPkRTjSrFr8Fohd5l
   rx4hZ5IlYRnCUAepcBxzEhYuFrHSkow2Fxwg7M9CbXwOo5o4FtNx5riF2
   fJz7BminqXS7x3Kf7K3bDW08nLb1Dw8brsfp/JfrLczyEf1bGRnS21wW8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256547143"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256547143"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="714959179"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 01:57:53 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:57:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:57:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 01:57:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 01:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrO3YWHddel+hcQmcGfq4ymJ+5nzi1Wb84EhnPcVJJQwTMmr5PqTiv1FZD/HpVC3aOLt+zqstYinnhiYouch5WlwFl1hPkoujoV6ZjEQt8Nrn0jHDBltevmskOj15tyW74rtGGAjhSnpb2qLDqiLkYZmuAHYI80aGZ64tthSI3hhH7nF8hwG4vHEgc6SoN/kjY9p1Jd+LEnpTybDtr88rEw04J9J2kwSSVk8io7PQFqhRIcstd+JtQHdJAfP9dSQLRqzvpqrFGF+G3XfVoIZ24XSWaaFVQI/LwZM0c3hNqqatW55mEqx6BCNT+LICtqpu9N/phLmw86Q/gNs0jC3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wop2VrOjV5rptE8XKe+x8Ov6UapSLu/S7xi1Askmyi0=;
 b=bT7LWf2nTdWfsOq0Kf7LCwYuotUAgEM860UYbXG7J+szOlrcvORB8px1QHQmvz9jrnNl6exuj2zO2eTO7igd7vOeMRVkWDKqZ3Sk2zGkCsTMuCqWTQ2y1c5dFKQBTdaqIXmYFkvTVqDOqr020/wZWCmbpyubtlEzZxtKeBuGIJAlzEblF6ayeivTrWLPeuN7XybC+SgweYX4TRiEbdNwWFQ+N7kzWfzFZUaCK1l+OK0LyNfyDOyHnhxSKTLxtG/lTXbct/0uoNeYIaPm/UmEwj0eVbGzFiWnaq5dwHKi8Z8D+OKfntZzCxGjaIzSsQEJelHylHtQYDMado/w84UOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BN7PR11MB2610.namprd11.prod.outlook.com (2603:10b6:406:ab::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 08:57:35 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:57:35 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
Thread-Topic: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
Thread-Index: AQHYOQUdy5VVRHPbC0+e1MzNi0A5CazDPxmAgAACSqA=
Date:   Thu, 17 Mar 2022 08:57:35 +0000
Message-ID: <BN9PR11MB5483F7CD0E49ADE326D866B9E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-3-tianfei.zhang@intel.com>
 <DM6PR11MB3819F26BDA4AA2826AFD5CA285129@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819F26BDA4AA2826AFD5CA285129@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 7acb36b7-1189-4460-e31c-08da07f42e03
x-ms-traffictypediagnostic: BN7PR11MB2610:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB26107BD9E93C02FAB1D3BC29E3129@BN7PR11MB2610.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZxEDp3DBJqYmfcjJnKm/Igtg0B1vAtY6GNQcnMdyKwYldd3ucMUheIIAGs2IpVQFnXEKZzQfqe8jGM1P3OG1ukJu/b2vx0y26xZB7Z+o1FWFwA1WnN5GovPzxTHVOhg5v+PSyfCgQnKuvvLvOKUGgg1aapc9aGo6iK7Ud42wUv4WXg5TbCpls1ScWFNyrp/QzxiAkMe54OLquixf6oA/R/M+Pc4TykIaxLLRJFUM1BEXmSkgLBVYfGP9EEfiQgtopD0+FkR8bm5OeDXgxxXn+ZJaQKmknBlahIGgt79DZQO79xDw1MGLprI2FSWPv1by1S0eR2G8pyV0/Wz9mq9dY7MiTmC4ldCsizTgdGb+Z/nEr4mz0UKn7aTvPI24O3PncLWa68wnbMxuR5KiyKz6XMOvBMnI98n5GvkyHzKcWzAqsnUHlZbkGDlE3PagpJ4dn+IyC1RVyvFYwbQSGBtMgsJ852hjk9qenpGFB1lFmLu3XB06S+rcoq+YrZ0bf13NvTBmCm4PObKSE3G9Zau75CWboR9Rhlzs6WX4tkYMZt5JkOt7CEaD3T4sxHc1cLCvlQXaJg6BxOwE+66M5v7sVl0delZ5hJ0uXG0/UjRw9KezsTA8zgcZhp/bmXc5OHj7e5Lqquv89dC+05sItiis48aCOHIe8IH98zzMYSQIUb2jQLwA6tPjBLO2EvNPsREzc727evnQ09p+o9phLM5k3P5kqnpgEBeDwXDBLWzHZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66476007)(55016003)(4326008)(54906003)(7696005)(6506007)(66946007)(110136005)(71200400001)(53546011)(66446008)(508600001)(76116006)(8676002)(66556008)(316002)(5660300002)(52536014)(8936002)(9686003)(83380400001)(33656002)(186003)(38070700005)(86362001)(38100700002)(2906002)(26005)(122000001)(921005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MhT2Z9xY8Qrog/RHRg/287OH1qp5InES+NLWo0Ve9K1lar+bXe+Zcii/MxLn?=
 =?us-ascii?Q?R+ibl8TCFr5ZocpSZUV/vWMvY8jsLz2QO//RUbfYLN9seP8YwAAtkkRzUJ3b?=
 =?us-ascii?Q?t3kVJUMqGzrTzARNZyGMzXQVD/iQtDnru/K90vGGeYoc2ukQTUB12xFvwJ7f?=
 =?us-ascii?Q?yCX2cjshXZ79L2f1aiKFVjGm8Mz9eG4YOKVqZh8Frj6yn0JnVlJdMjRUDf+V?=
 =?us-ascii?Q?P0WN/0aARhOEoReItjU3vp2CoR5TE1eoTonM0D/oPj5B6xpLy8vBMFLRMyaH?=
 =?us-ascii?Q?9ocbqlo0dJ09BjD0IcKN6xIIIrW90gG2iHiAaWjR35+g09+FYTVW4b/GGSH9?=
 =?us-ascii?Q?MHGkOxFv4Ly0exA7yBPWBwJXYttYKHrbko7yD971TBS0GZPjXDE7sz53kgjO?=
 =?us-ascii?Q?VgD60ZZbCsUk9BCMsS5x1gXt6LDRDzO8ow3ulpXWRqaBFErfdzG1UDe0MOyk?=
 =?us-ascii?Q?jb/TjdwdYHaWrctLCr2ULl0z7vaBAjAyeyv+WcjNSQJx/YiYshL7QgfpRzTt?=
 =?us-ascii?Q?hhkTibXWCTjneP3Tl4rZdjNIJrrUmlTLbq5FX+CrWA8LjeD9yFvFHR3nWD5Y?=
 =?us-ascii?Q?XgQKWByD5jPT8oa/4O/GqgNhXJHSghgHw9vyj3cPF9sqI9KIdfBGZ9wLTpDL?=
 =?us-ascii?Q?t9aZr3KrIYCwN+DrHQlJcFQB4e8wvLPkRURARVN0OHKSKiZs3cB9MmmgCMIB?=
 =?us-ascii?Q?TG4V7JSrc5cD3zC6KYD5NvTtB3Wa/0NTW+VrABuPmOMTxjPL0MPPHePqJJab?=
 =?us-ascii?Q?fxWKMC5+hzRlsPUBzwvOsiot5CwYt+/6JJDlt9/vmLSJRBlESxigQN7CKrT8?=
 =?us-ascii?Q?oJmM7MQtvAOmraLp2YQfjOXHSv5pcSaCBK08xaAehGjaus9VhYatS1k0mZXS?=
 =?us-ascii?Q?DRlq0IIfOFmk9s9SwS8zGXJ5AzjF7ZJmD+YFQ7AZ95kZv0a0hJj7TcfM2PJM?=
 =?us-ascii?Q?m97zzYpYAN768XuWinjn6KRcp1e7Vn7fZU8QVwGHP8G6r+6t6+vlM6qHFlUN?=
 =?us-ascii?Q?NCPOgqh7g9rrWY/U3G9bnBdaodA+Z6QC9XsHiAZUbdF4lykemKuDfJO1x96P?=
 =?us-ascii?Q?sqCWi/ej6xy2krX1pYxMQfs5vdGCgpmdIC0f7v9bX1Ow9dWT1xraawQAZIjl?=
 =?us-ascii?Q?NoyRa4jbEISQxAlp+6uFxC3EO+vlRH3glTZ7L6HZVRzsmcKuEgmlOFdx0grE?=
 =?us-ascii?Q?wJ5pbnmyVR0p4LgZC9G/+My1c3PxWMFkWO8RPSpZ2VU6SUYR/0Emy1BqLnea?=
 =?us-ascii?Q?bdr4w3Q4Fxr3qb60/5JnP+YmKAeTbtNFTC9N5p8/aII7P6dDogIb18NshSkj?=
 =?us-ascii?Q?xM97jOqVCfmt49JKIvTLJ43tiYvZoIRHHNK7845ZQXFBdmbwe4W0n01Lgv8e?=
 =?us-ascii?Q?lJ7dAQizxKJpieAx7d73orSvzh9q+zRsqy4HA24Zt8wj0q3igQojAgnvfAOs?=
 =?us-ascii?Q?AvTwD4sQlVWORKqw61TwB1KhC+KtyVAs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acb36b7-1189-4460-e31c-08da07f42e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 08:57:35.0674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXbJckidAOegR6ArleF2W2r/X1Tegmp1CwfJ4JAoJ3b2eEuIYRhbTZiJDQZhHFP6NkcO3uyO9pXSj6OltUrf4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2610
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Thursday, March 17, 2022 4:26 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> rdunlap@infradead.org
> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
>=20
> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Wednesday, March 16, 2022 3:08 PM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > rdunlap@infradead.org
> > Cc: corbet@lwn.net; Zhang, Tianfei <tianfei.zhang@intel.com>; Matthew
> > Gerlach <matthew.gerlach@linux.intel.com>
> > Subject: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
> >
>=20
> "conntected" -> "connected"
>=20
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > Introducing flags in dfl_fpga_cdev to track extensions or new features
> > discovered during DFL enumeration. It uses some lowest bits of flags
> > to track the port status which the AFU was connected to port device or
> > not. In legacy model, the AFU was connected to Port device, but in
> > "multiple VFs per PR slot" model, the AFU or PR slot without connected
> > to Port device directly.
>=20
> It's "Port with AFU vs "Port without AFU", so why we have this flag in co=
ntainer
> device not for each port device?

I think this is a global flag during the DFL enumeration.=20
After the DFL enumeration, we can know that the Port connected with AFU or =
not.

> and probably you need to describe why we need this flag.=20

The next patch will use those flags for VF creation.

> What I am thinking is
> that port driver can use this flag to decide if afu related interface wil=
l be visible
> or not...does it make more sense to have this flag for port device itself=
?

The different between "port with AFU" and "port without AFU" was that the A=
FU MMIO space add into=20
AFU driver or not. In "port without AFU" case, we cannot access the AFU via=
 mmap API. But for both cases,
we still can access the port device by "/dev/dfl-port.h" device nodes.

The flag was used for VF creation. If we want to put the flag in port devic=
e, I think it only can add the flag in port device's dfl_feature_platform_d=
ata,
but I don't think this is a good idea.=20

>=20
>=20
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl.c | 11 ++++++++++-
> >  drivers/fpga/dfl.h | 12 ++++++++++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
> > 599bb21d86af..712c53363fda 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -1124,8 +1124,10 @@ static void build_info_complete(struct
> > build_feature_devs_info *binfo)  static int parse_feature_fiu(struct
> > build_feature_devs_info *binfo,
> >  			     resource_size_t ofst)
> >  {
> > +	struct dfl_fpga_cdev *cdev =3D binfo->cdev;
> >  	int ret =3D 0;
> >  	u32 offset;
> > +	u32 port;
> >  	u16 id;
> >  	u64 v;
> >
> > @@ -1160,8 +1162,15 @@ static int parse_feature_fiu(struct
> > build_feature_devs_info *binfo,
> >  	v =3D readq(binfo->ioaddr + NEXT_AFU);
> >
> >  	offset =3D FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
> > -	if (offset)
> > +	if (offset) {
> > +		if (dfh_id_to_type(id) =3D=3D PORT_ID) {
> > +			port =3D FIELD_GET(PORT_CAP_PORT_NUM,
> > +					 readq(binfo->ioaddr +
> > PORT_HDR_CAP));
> > +			cdev->flags |=3D dfl_feat_port_connect_afu(port);
> > +		}
> > +
> >  		return parse_feature_afu(binfo, offset);
> > +	}
> >
> >  	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > 1fd493e82dd8..bc56b7e8c01b 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -461,6 +461,16 @@ int dfl_fpga_enum_info_add_irq(struct
> > dfl_fpga_enum_info *info,
> >  			       unsigned int nr_irqs, int *irq_table);  void
> > dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
> >
> > +/*
> > + * Bitfields in flags of dfl_fpga_cdev.
> > + *
> > + * 0 - (DFL_PORT_CONNECT_BITS -1): AFU was connected with Port device.
> > + * DFL_PORT_CONNECT_BITS - 63: reserved.
> > + */
> > +#define dfl_feat_port_connect_afu(port) (BIT_ULL(port)) #define
> > +DFL_PORT_CONNECT_BITS  MAX_DFL_FPGA_PORT_NUM #define
> > +DFL_FEAT_PORT_CONNECT_MASK ((1UL <<
> > (DFL_PORT_CONNECT_BITS)) - 1)
> > +
> >  /**
> >   * struct dfl_fpga_cdev - container device of DFL based FPGA
> >   *
> > @@ -470,6 +480,7 @@ void dfl_fpga_enum_info_free(struct
> > dfl_fpga_enum_info *info);
> >   * @lock: mutex lock to protect the port device list.
> >   * @port_dev_list: list of all port feature devices under this contain=
er device.
> >   * @released_port_num: released port number under this container devic=
e.
> > + * @flags: extensions discovered during DFL enumeration.
> >   */
> >  struct dfl_fpga_cdev {
> >  	struct device *parent;
> > @@ -478,6 +489,7 @@ struct dfl_fpga_cdev {
> >  	struct mutex lock;
> >  	struct list_head port_dev_list;
> >  	int released_port_num;
> > +	u64 flags;
> >  };
> >
> >  struct dfl_fpga_cdev *
> > --
> > 2.26.2

