Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3751BC2B
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353325AbiEEJcY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354076AbiEEJcO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 05:32:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67483517F7;
        Thu,  5 May 2022 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651742861; x=1683278861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NiPREoiHI3Pnqv3KcxfN7tn94Zc1lA8rzr6ibO89HA4=;
  b=nL7N9eN0Rx78Uw6kGWwaEpeNg0VLqnilDzzssKH7VxwFjybH2rARdpJm
   8+yPIChKqhXgFegPd06Hh3yIoj0+Gppal0Q7oTeE7edybmQQB8q0f/Qmi
   0RsdZMqe17vsbvxXV7ACLSv0FLFdd4vlEcJCc6FMlSwi9HYYVepQz8cql
   /AgPBGtFcyGoje+E3piuHorGEshW+cm/HZkyxZKvoByQpySkBiiHkgOZd
   4MEbQ/zNSrsaVro3iLHOfN9xoVTGGPjN+xM6Aoycj6s15052l6mbNhqAE
   RO0fHUTWpfyVYvmHSlyIKE+X/S5P5iDYpvr5HAZtCsBDGne1Q2FznLzFB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267940655"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="267940655"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 02:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="537255439"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2022 02:27:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 02:27:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 02:27:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 02:27:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 02:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6RKstNLNWz+9GTN/W2jz8lm4zrW2MDiSpnUJsf/KykU1Z7KhjJSLCPM+q5euEGNThUns5bQpDhPSSzt6AqHYn/XL1mePNU67YQRLtiPtN1Cggsfd9O5xPDU72aht7H10X9AuEp5iHau9+dwR1KffdwSn7pv+uwHfazvS7qZThqdk9ScLuzG8TdUnS7UsR5eiXfJKn/zkBdJRG2Cqpd7KeYeaXhM/xxNHOY/kMX8WSpfXXphJtq9y30ZXFE0jxhRYWvCnrbamyF1onJKUqg/efFuVA2JxsfN2zE2T99KwUg5ssQdVZLYvouOCsIJDKBLXpbKoaxfqzE7DLUqqau92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoekToDkdTfJp+TRxv20UJSgMu9o5b5/Vh8obHdUW9o=;
 b=J4lv6xU1/93TJEpgDvBbPTGELlQKiXRC3a1/2pa3zsC1RwZGj/7blKVedrnVz+rLIg/p0wocGAzRbIcgd4GFkYkY5PP4LAzewv0kVpvotxKuFVHwlSD0EkovwYZ6S4Lnt6pa5cCn4T3/Qq7iEnGzCUeWb+eHGvAq5V/QJXSRuYIGtz/GY+KOb68V8RofFR6z73LRea+ujKLPaLK0fC0qjdGhktFC1Zzh8QNMrZMR+FgjdMkTBNr63AUFhpFrkjiLALDhNLQRwC8XJPYjCBorzfSgDE+s1THlYUamFgE046TcVbH+081BbwkH3ghO7ymKtTAk1wrohbgwOdhgV9bjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.25; Thu, 5 May 2022 09:27:37 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%8]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 09:27:37 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Thread-Topic: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Thread-Index: AQHYYBXhq0QLvnormUiUUyimXrfATK0Pi+KAgAB4fPA=
Date:   Thu, 5 May 2022 09:27:37 +0000
Message-ID: <BN9PR11MB5483A1C8F7C52E4331CAF8F9E3C29@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220505001628.681226-1-tianfei.zhang@intel.com>
 <20220505021545.GA417720@yilunxu-OptiPlex-7050>
In-Reply-To: <20220505021545.GA417720@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 2937b3f1-4d29-409d-de6a-08da2e797e74
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM8PR11MB5592AD94ACE2356A87911590E3C29@DM8PR11MB5592.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6djhnpEFy6Gf9u73+cPcHwAuNwoeWYu7EphKqyXHVLMhIldvta3PLheNw/00Dzu1LLexlzueMVMFMqoScmpejnvrBUJ68PGByNi4SaTZF8Q1IdlsdCXSKKKA8+SAXO/ly3Q8fd4NfwrwPM0fzHXQ6apbeA9+2keI4dX1TllKh9wpqIl3Pp1oEeZfR7NapH+6O8iBUIKrhzRb010IUPnGYG3wxF27DiBBRta2TqQsG1/pTaoQfLgMmnaWrmYb1dTcGqAikT8XQ0O1WXvTHcu1HYcEQ4DsM4dhJjjTr9W1Yl8wjZ1JELgEsmpIM+KsgPkzt9RakfcWUFXUpm28OZUgGIpPwWBT2SmeOdg0XT756umRDWg8YnbujSxFuq/ivyztIqjQuYv4YdNsquYFF9SvdRksBizPStvKQqPEU6G/v5PN4zYYBbJrsTLMMxqNhQ0he/A2cvIFLuR5bpLzZ1+UoDmwmIdxqxWWsmXtjJsN14bBjh/Y+E27Ox67R5qOf3NkoEmOc1Wl+dFCMs3COyGEBbiuC9xmP9Vb5rWJe9zHFfXbWvoHPq4x1HyThhzkCv+NWOX0Eg+5rIau97HfQXDaMX1D+hj3XlDkPu74VjIZzUQXYeVoKubzQLcqwMyAOumKKpYT7NkHyWbUc5xcus3MsH3i/k18T3CixgiutOit+VWREzZWOGg/A7pUlbGkimuspMgdtzLsoPj/OXnKomJ0mjsIxRxrD9u4cVWNyBCg/wSGANNvx2lEEb63KAqDm9aia7DhdW3k2iBx6IKn9F2bW6yoHY5u5Xidyd23281Gi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(54906003)(5660300002)(966005)(71200400001)(66476007)(52536014)(8936002)(2906002)(66446008)(64756008)(316002)(6636002)(66556008)(6862004)(4326008)(8676002)(66946007)(76116006)(7696005)(33656002)(26005)(9686003)(186003)(6506007)(53546011)(38100700002)(38070700005)(86362001)(55016003)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xtYWB1nSBMw+Ww57z8mDsnMRA2yMjlf4/LNpan7fltSH6KUngUe0JwKhybAP?=
 =?us-ascii?Q?Pp5f/LvKihpRwMle3XFsNIF6ZBv/fSC4ofbgs4av2UrL7GtiDwuPr59JOTN6?=
 =?us-ascii?Q?TiQrj2p4KKIbSD0HQC/f8Yjp7gdwiqQc26mGqQEtr/qwjsMe36/FP4TNrMdK?=
 =?us-ascii?Q?cJYXE6YSdSASF7r0WJ39ouYPEcAku52quQgnm+7AbBpgnpjSkf/GptkZ/Mi7?=
 =?us-ascii?Q?kwjLp0ImOFSlMqkZa7ZWJ6Lck6rnliqr4ADALWCzSs9+H9ZyCIkzfmOCFJ45?=
 =?us-ascii?Q?JCdbi4MlI/iLa1CqSBLBxHdEsdhV+O3sktBnuwq3nbxowHiVCiK+2ZlcbS+a?=
 =?us-ascii?Q?wiGEhPzsCVrwaLJcB0gHd2XiAcYXK4aEl1MVXSzVJFzL/bKCZVvo5Y5qoJQK?=
 =?us-ascii?Q?PvSkythd0n9UuSM8Lyq24QcYP31UqMN3gcsojblreAHK1R0zfWvLWW2OKmtK?=
 =?us-ascii?Q?EW35TBbbydC6IJmvq/5eswMZimpDAI5V/KWy23s7Aro0uH0ulox1TGXr/duW?=
 =?us-ascii?Q?FZSQkrmMcqW7lRy+3vA1rqYsepx/ozQgL4WlPtQiph3cpWNf4md1jXo9uQIU?=
 =?us-ascii?Q?yTDKCUhBFDXWwWFiiNETO16A/jmzhK71plZ18/X/Y/job+zYV+1Wp/He/jj1?=
 =?us-ascii?Q?1BbGJaSmvMGaXFNRgzfVEyONoOJoIaKAlJiNAzMqzKQfXDLTEG4G+B5c0tDY?=
 =?us-ascii?Q?30RAiOydfEnHNhNNlETJlzVPVadlC49h9oJw8RjAF/qk1DKRC3bflkMFxE4l?=
 =?us-ascii?Q?j8imQSv4xL0OZzM0/GRvBRM14+KjHaCzQtqzoaMzLzBmVJNzvYRoZ5RxojID?=
 =?us-ascii?Q?WhJz4RVYvjQVEUC4zHvP4ZH5leDzq4ki+IdUsy6SRiC0FnGcOfaADFdkKO58?=
 =?us-ascii?Q?KCvNUj8lKmn4xpMunJlHuu55mrIP9l6xi0kDGVEYm42J97QurfdwhInfJ2DY?=
 =?us-ascii?Q?Oc1bBBRQwc1NrNW+sTXR3pwtVzYXkxKCbDsHU9N+YinSu4idYDyW1Eskys3L?=
 =?us-ascii?Q?lHkK5YIVC7bfSThsSaJBjz0AjVdLp25U9IBDgarhyr9LSZnlgKHP+4cO3s84?=
 =?us-ascii?Q?pCQCx9qxSas+CqIuDnp8Va8vfnCALzxiz5TOaLYwFBdHbXYA30b1hKdU9wLk?=
 =?us-ascii?Q?MAEZKsZh9qJUTMGbk4ybSCCZhRlxGicGLgDXqWyKJtVTCbxFNxWM9bBNKDap?=
 =?us-ascii?Q?91A4/3XHvaGVl9lGyKGv4PmXBm3X7Qma4AbtKd6dS5CAl0LHP89wKOC/KJfv?=
 =?us-ascii?Q?ltu/yz2VPAr/uBjR42WdJu34DkHSP+STmPjB2c1LN9As9zETXjPwIsMxR4T/?=
 =?us-ascii?Q?EWaDY3BZnAYjxAKqVCvHAZDGgSyap/UypZacj6PE+CR8Ms2xsvf1zgWSRay/?=
 =?us-ascii?Q?Bz2Bk1KvhLS7BLXi0Dl1HWfAGIXF6idgR0lixCi0ve9R//s+ssdmFN7713Ob?=
 =?us-ascii?Q?6AUQ8+SyAOFK9wcxNiHC8cyIPH9r9wf4sGAlYH8IaGNPeWeS0HbQnX48vXKp?=
 =?us-ascii?Q?Iw45pMQ0hugIMoaa4g16ZsmmtSx/jTA/uLdMzNbXiftjxO6go9zU7h155WFQ?=
 =?us-ascii?Q?e/+QsB5TksHkDJqqVe90wPb+NK2037uZH7VcwWxtDQoGd7Dgrt1m7KdfxS8s?=
 =?us-ascii?Q?Pw+AhlG9C9x/lx2XROxrxakJD/pRhJDadp5CtFoHxn5F7qtoYtUkilZ8yGMf?=
 =?us-ascii?Q?P9Q+XAZgU4K0tBBsjGzFvaIXMtjBzPNe4c1HgEUDoEzvZEl3nF2/yyCIOc6O?=
 =?us-ascii?Q?raa7ShOf9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2937b3f1-4d29-409d-de6a-08da2e797e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 09:27:37.3230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pzyW5BC3VhowfdPrGaknmcaYnBLJ+ef3pxWDA+EfBzp55UOAPCzJ/yktbjGyuqHqSJClqMEdTztPC0hG7eSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5592
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



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Thursday, May 5, 2022 10:16 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; linux-
> fpga@vger.kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: Re: [PATCH v4] uio: dfl: add HSSI subsystem feature id
>=20
> On Wed, May 04, 2022 at 08:16:28PM -0400, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Add the Device Feature List (DFL) feature id for the High Speed Serial
> > Interface (HSSI) Subsystem to the table of ids supported by the
> > uio_dfl driver.
> >
> > The HSSI Subsystem is a configurable set of IP blocks to be used as
> > part of a Ethernet or PCS/FEC/PMA pipeline.
> > Like the Ethernet group used by the N3000 card, the HSSI Subsystem
> > does not fully implement a network device from a Linux netdev
> > perspective and is controlled and monitored from user space software
> > via the uio interface.
> >
> > The Feature ID table of DFL can be found:
> > https://github.com/OPAE/dfl-feature-id
> >
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>=20
> Please re-order the tags. The earliest at the top and the latest at the b=
ottom.
>=20
> "SoB chains should reflect the **real** route a patch took as it was prop=
agated
> to the maintainers and ultimately to Linus, with the first SoB entry sign=
alling
> primary authorship of a single author."
>=20
> For more details, please refer to Documentation/process/submitting-patche=
s.rst
>=20
>=20
> For you case, I assume:
>=20
>   Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>   Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>   Reviewed-by: Tom Rix <trix@redhat.com>
>   Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20
> is it?

Yes, I agree, I will send a new one.

>=20
> Thanks,
> Yilun
>=20
>=20
> > ---
> > v4: add Reviewed-by and Acked-by tag and add Feature ID table url in gi=
t
> message.
> > v3: change the name of this feature id to HSSI_SUBSYS and rewrite
> >     the git message.
> > v2: add HSSI introduction and the git repo of Feature ID table.
> > ---
> >  drivers/uio/uio_dfl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c index
> > 89c0fc7b0cbc..8f39cc8bb034 100644
> > --- a/drivers/uio/uio_dfl.c
> > +++ b/drivers/uio/uio_dfl.c
> > @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
> > }
> >
> >  #define FME_FEATURE_ID_ETH_GROUP	0x10
> > +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
> >
> >  static const struct dfl_device_id uio_dfl_ids[] =3D {
> >  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> > +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> > --
> > 2.26.2
