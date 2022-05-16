Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAF527C32
	for <lists+linux-fpga@lfdr.de>; Mon, 16 May 2022 05:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiEPDB7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 May 2022 23:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbiEPDBy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 May 2022 23:01:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC311929E
        for <linux-fpga@vger.kernel.org>; Sun, 15 May 2022 20:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652670091; x=1684206091;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dfYPwxamyW0UwNHUw+SYJm6SNxQ1U/dG4AvAKhgy8qM=;
  b=GqOze1XuCgzelpvS4RYZXcxx22Bmcj3ubqtoSmfsyRq2e6pVcCqrAWTZ
   WxaOXLIHNCyRYBSiJFS6V9CxRvfESCj6G8xEOy+JE5EAJjnoER6OgFVfL
   uRVczZDIT+BgTeiHvLG5SaHS7YcdYSCvqVI3NgS06/FK8KBzR8U8zAbY5
   9UgTGSD17gkDtR/Dkd8srKEKCa38SR5wOfZAYQAynS4rk4vRs7grD1tbs
   2/nEVjee8Yt4D8g2mIFPoJ0d+LsqQQxE1JeczetbKk4BsSBdpu7gsykKD
   itWZnGZX6V+iNbajUF+dYQqpVr632trKU13JtRolMJoqeZ6iD0bFy7VOE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="258285586"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="258285586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 20:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="568109438"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2022 20:01:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 15 May 2022 20:01:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 15 May 2022 20:01:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 15 May 2022 20:01:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 15 May 2022 20:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abOuS01EED+rMrFQjjPQR9SNfM0thR9WVhTP1s6fkveifUOQLLvwDLmeFTgcBFPY6sRcnzTIJCEnquCfZZjIqEwOPywdodazvLLMhDRYguejGU4FQ+FbKAck3t+lYLFfW5SXLjN7Bs3gjGJ6UE6MiHPcVczS+9kne2IUYIhErIJhK1suLNyxN1ic1xuz3cKPs1iQIaRcqBo+iNZCWGfI6dsZEr9S/xIKbcqbsHUgZgCtsqZLSLUqV72nrmlKF18JMR07ykqdknbRUMSU2+awRrTa9RJMIkD+lEeLy7ESR1gVbT4p45437kCxvCtVNSu82jpRPLzOUIDIrHwSgUG7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdbVxHaEEWDvtHeL94I3DeLQws9QM2h26BQbsufqLeY=;
 b=Jv05BB/VEzO3TIhYDV2sCVBKFJ+oxJPoeTxVngUDtSSLTU7RHuKwXzCbQoBBqVDxKNLX8dYzNIo7m06AaojH/p9IH53ro/2WjLWJBEXTW5/uJA4OWH6/uMRf5mdhoubBMFWJpSU2C+Y+h8cCO5yLCiilAwiQjy4SGbPdQ0EpQhWbBjTJyLrO5CQwqCbuYrYaKJ6npqC7eNuwPmzs5I7tHAw/tBpDF8fTTSctv4HBT0wowhBskeQ8gwwUBaVEmYhszJmBvaTrkx0Zp7cGQR9saS29ImsxPEyVMKuOcXqcJs77fc1Sah1uC48KySHgdFGmn+4UP2IX6CG9OY7Vtv7Vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SA2PR11MB5210.namprd11.prod.outlook.com (2603:10b6:806:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 03:01:26 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%8]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 03:01:25 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Topic: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Index: AQHYU5qxV39Tq0+gOESHo9irwPi9fa0P8KEAgBEHtUA=
Date:   Mon, 16 May 2022 03:01:25 +0000
Message-ID: <BN9PR11MB5483247B6B612CC9A82B6C43E3CF9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220419030357.410495-1-tianfei.zhang@intel.com>
 <DM6PR11MB38195D7FDC316CBDEA55D91A85C29@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38195D7FDC316CBDEA55D91A85C29@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: bf7dac27-7b54-4f30-d5ec-08da36e85d98
x-ms-traffictypediagnostic: SA2PR11MB5210:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB5210CBEB41F83EBC5D0182C9E3CF9@SA2PR11MB5210.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFMwKEkfgCDQ1Bpu9ptSvwcuwRhchj2cGgSiBywoeMuU2G08HV5uUOgOj0sGM7il+gxe/ui25KRFzfQbyw2tZODMza8sPa8nLR743XLn+582EGs2DxNggSlvrNmt7Zj0cxwlkKc+R3HxPnK51TQBM9yjmqS8BRsKR3Vmb/7nNb1SEFFixUB11a56ifpFMxlrcq1NgRko5i47XSEAV986en47Gr1yYkWWdE6n8HuFQmriRJU4t1+b5f4BRatOv42SSMhdAoNQFginwLfiagAfkPMhbzzS9CPNePBBoBeQ7GrnaS+4/P3seyH8CFenxmSIg9o6984MmWeMQ1TeW7KIyvQPU0i72RdmPd/gCGI9hfEc9o+KdLbmSrEuPzwJ7/pUj97Y8eOHtB3TD600xImEwLX/v8O9UYRx2RdomjpWO83zcMxkB4pOgK7iZyQ4rDmBjngkVmJmzJI17lJMqFcT6NUkhh/ndvZNbTtt4O5omF3ICJcbQs8rHsmLDvQbBH1GADwUZdgxLhl8KpabYkKcgqnZe5C+BgpEyxC7/CtRRDqVNyrzUiqIe0EKoi2EZVhx4ognq4gnobUJTB6HT1FyHmDFCN98H0H/x0uXH0Sjxi5g7hb20dzFHYfKaS39R9gQPIQwrtv7NYaH4TR4jWXJ7yJZ6EY5W11ybAqh4vTinV72yZ1BBl5wu9IcffijWupsKtQGzifnka80N+tPbOrePA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(71200400001)(186003)(316002)(55016003)(2906002)(508600001)(110136005)(26005)(9686003)(53546011)(82960400001)(7696005)(33656002)(122000001)(64756008)(76116006)(66946007)(66476007)(66446008)(8676002)(66556008)(38070700005)(5660300002)(8936002)(38100700002)(83380400001)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H8UK4JGGdPY1Oj1pNYRWwZwTKoecsL7ZE0wqj5AT2CQqvyFtiKs+JhJPfBI+?=
 =?us-ascii?Q?GzX4fzfENNSkXK2juhO7FrBBaUPOq4xubuZltiHL4dYysQdhd+H6cXCbKouO?=
 =?us-ascii?Q?lia+1UY8wUwDIO71owYwJhzYcrqv+z1vMDgSSHdznJOj7qTqUbB94LIQwY1Z?=
 =?us-ascii?Q?tUZn1uc5dXYfrbhcpoDxN4D5JokD6UIy9ZRtCAuLOfA82elqDntKxDqsQKOq?=
 =?us-ascii?Q?SH93pWC+SkZ1f6jrBup5xsqQt7e26mAOQ0BBh/vkDHEnqkm81Y6LogqM88Pc?=
 =?us-ascii?Q?fzwOsdAZd4w3PZFviwES9A+iDn2QZzNZa5L/u2o7v00fAy1bBwgD72XVGkio?=
 =?us-ascii?Q?zYjq8anzy2VFJSSbAdUAXl8r3G0+iiMQEy8kVo7/G/r1Yv+kkozQmXz8VtUK?=
 =?us-ascii?Q?whwhzKjIFmLAVgOVRayIL5IKC2+vi4tOyfcKjkhzygZOursKOsFvc5PhRS+O?=
 =?us-ascii?Q?TMmuCMLFNoRKoKX5e5JSRdNrG2fhFMn7jC4vWpVFx2PUvwBOKzs2xKgnXZNz?=
 =?us-ascii?Q?ASIznd1raXxEKtfhJmeADRzqTG+4e1de65PlrUoifubHqRqjAlLAsafKJpkt?=
 =?us-ascii?Q?t8C+eMBVLEzWFYm7iVrEhuwvTo4KNC6SuSEqJ7DEbh+0CpDAUo3yix37GwUP?=
 =?us-ascii?Q?5waJYZ6ZlhdcDiWHIzKrxW8B46j4ESLt+BEPvmXZRHrKU9ffbxIW4WR1dB8d?=
 =?us-ascii?Q?nko2JMR+uVlNmoFTh8KcBmlW6T5tBD2i+FTGsQn7IzNcIEyr3xMaFSxm0dtN?=
 =?us-ascii?Q?lVnldfdnISChs3MLogoPB1BEhNKPn3HgkFtOHX2kZyVSuJOzaxt1KTGGGM0r?=
 =?us-ascii?Q?3fZxCX1OUr/eJsxglTHozXed5Hpia0JzhnjJfewsV0L3cFeYh0FvuExdGAgC?=
 =?us-ascii?Q?itcQgfVO+Ltb6u7RzG8Fuprch9YydrROpdCaibAXkYXadh7mQjgKjY0wi1wk?=
 =?us-ascii?Q?jmQEW/EqMDC7uML+UTT+yE8a+eEamGRwbZqIK0kfEqea7sIIyJWUuojhxBg1?=
 =?us-ascii?Q?CjyYQmi7cvmpnMLEcNEd2+KIA34MsCFxFp/Gq8fWVB1zlk5m1FOKbZKedN2f?=
 =?us-ascii?Q?XN0l8IqSHuNTXKrcuVSekUGVIcO/SBzkmLB9rX/f12QOjGRtXy/t5SW/RBDM?=
 =?us-ascii?Q?JKdDqOSOWLqtjN2PVk2EBjVQEC5Q8VQoryQvzNA1OGD0aPzUm25zYA2lmUNv?=
 =?us-ascii?Q?rHgZH7Db6120r7rheQpdC0mZg6JO0GkI54etfZZdlkzC6aC3MxZ/e90PG6te?=
 =?us-ascii?Q?64+qH7iKTph8RBlU3zsgYzzyhfFIOFqXJqc6ahVOXJ3+PCnrGh00qId12Ml3?=
 =?us-ascii?Q?EQfXei+jQIk6OuBt89regfCeauBC77gHsLSEhd4E15x+BnppTtTaSQTH5/qB?=
 =?us-ascii?Q?c/lwaZmMenhlUgC7WDaiDGsqaQTkKyiVEdtYy/nvWtkCFmliEeQR5lsfpMEe?=
 =?us-ascii?Q?B35x6MrjgLD6LU4sPw+gaPDTmbN6Nabswyd80O1x7e4iU2oZF+jVZ3obFtBx?=
 =?us-ascii?Q?4dUHX8BVR8peze68KFKxjxLLjCaGE9UcUgFVSgkIU8erMVpiAobsYcAN8G6J?=
 =?us-ascii?Q?1sbf4qG9AOBHpbaS/zzsq5ofkShT06IFIzVTu4E1alHPF+++lrLrF3+fvH7w?=
 =?us-ascii?Q?JzaetRC+1KsLJnm56M9tG0W9CeImCefYC0EFXzuz9ihpwy/7csJsAUSHc1Wj?=
 =?us-ascii?Q?zZiRpiOJt3epZossJoDkyPfcJKu+X0YKmlVQILUuCYWHRD8NQyZ6y7C8s33u?=
 =?us-ascii?Q?FE8ETv8d2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7dac27-7b54-4f30-d5ec-08da36e85d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 03:01:25.6644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3uqBQXaCePDEhrSkZO8UNKdCvJy2DXfbvL2Uj6eRE3ArOzNHZHahvZgfJ+4Chv1dr7zNDa/xawO0FHUKVDLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Sent: Thursday, May 5, 2022 2:47 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g
> Subject: RE: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision=
 of
> FME/Port error
>=20
> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Tuesday, April 19, 2022 11:04 AM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org
> > Cc: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Subject: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision
> > of FME/Port error
> >
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > There are 2 different register layouts for FME/Port error registers.
> > The new production like Intel PAC N6000 plans to deploy the new
> > register format which it is more reasonable.
> >
>=20
> Can you explain a little more why there would be different register layou=
ts?

There is a historical problem for it, the older PAC card using the older re=
gister layout, but for now, we will use the newer register layout for OFS P=
AC card.

> There will only be two layouts or more?

Yes, we have two layouts now.

> Intel PAC N6000 "plans" to have new register format? Not finalized yet?

N6000 and all of PAC card in the future will use the new register layout fo=
r FME/Port error register.

> So anyone could define its own error register layout, is my understanding
> correct?

Yes, we suggested that they are follow our OFS spec.

>=20
> > To distinguish the register layouts,we provide another sysfs node for
> > revision info, but it is a bad method that using one sysfs node's
> > value to determine the usage of other sysfs node.
> >
> > This patch introduces 4 reserved bits (Bit[59:56]) which are reserved
> > by HW, dfl driver appends the FME/Port error revision info on those
> > bits for attribution on the readout value.
>=20
> Will UUID be more reasonable than just 4bits value? If we consider this i=
s a
> FPGA, anyone could implement its own error register layout, then just res=
erve
> 4bits will not be enough? I hope we don't need to modify the code and des=
ign
> again...

The revision was came from DFH_REVISION field in DFH register which is 4-bi=
ts, I think is enough now.
We suggested that the customers follow our register layout design.
In the DFH v1 spec, we will consider use the UUID but this spec has not fin=
alized now.

>=20
> >
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > ---
> > v2:
> >  - add documentation for this change.
> >  - fix the reverse xmas tree declaration.
> > ---
> >  .../ABI/testing/sysfs-platform-dfl-fme        | 37 ++++++++++++-------
> >  drivers/fpga/dfl-fme-error.c                  | 36 +++++++++++++++---
> >  2 files changed, 54 insertions(+), 19 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > index d6ab34e81b9b..b886568d6071 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > @@ -50,46 +50,57 @@ Date:		August 2019
> >  KernelVersion:  5.4
> >  Contact:	Wu Hao <hao.wu@intel.com>
> >  Description:	Read-Write. Read this file for errors detected on pcie0 l=
ink.
> > -		Write this file to clear errors logged in pcie0_errors. Write
> > -		fails with -EINVAL if input parsing fails or input error code
> > -		doesn't match.
> > +		The readout value has embedded 4 bits revision attribution
> > +		in Bit[59:56] which reserved by hardware. Write this file to
> > +		clear errors logged in pcie0_errors. Clean Bit[59:56] before
> > +		write this file. Write fails with -EINVAL if input parsing
> > +		fails or input error code doesn't match.
> >
> >  What:		/sys/bus/platform/devices/dfl-
> fme.0/errors/pcie1_errors
> >  Date:		August 2019
> >  KernelVersion:  5.4
> >  Contact:	Wu Hao <hao.wu@intel.com>
> >  Description:	Read-Write. Read this file for errors detected on pcie1 l=
ink.
> > -		Write this file to clear errors logged in pcie1_errors. Write
> > -		fails with -EINVAL if input parsing fails or input error code
> > -		doesn't match.
> > +		The readout value has embedded 4 bits revision attribution
> > +		in Bit[59:56] which reserved by hardware. Write this file to
> > +		clear errors logged in pcie1_errors. Clean Bit[59:56] before
> > +		write this file. Write fails with -EINVAL if input parsing fails
> > +		or input error code doesn't match.
> >
> >  What:		/sys/bus/platform/devices/dfl-
> fme.0/errors/nonfatal_errors
> >  Date:		August 2019
> >  KernelVersion:  5.4
> >  Contact:	Wu Hao <hao.wu@intel.com>
> > -Description:	Read-only. It returns non-fatal errors detected.
> > +Description:	Read-only. It returns non-fatal errors detected. The read=
out
> > +		value has embedded 4 bits revision attribution in Bit[59:56]
> > +		which reserved by hardware.
> >
> >  What:		/sys/bus/platform/devices/dfl-
> fme.0/errors/catfatal_errors
> >  Date:		August 2019
> >  KernelVersion:  5.4
> >  Contact:	Wu Hao <hao.wu@intel.com>
> >  Description:	Read-only. It returns catastrophic and fatal errors detec=
ted.
> > +		The readout value has embedded 4 bits revision attribution in
> > +		Bit[59:56] which reserved by hardware.
> >
> >  What:		/sys/bus/platform/devices/dfl-
> fme.0/errors/inject_errors
> >  Date:		August 2019
> >  KernelVersion:  5.4
> >  Contact:	Wu Hao <hao.wu@intel.com>
> > -Description:	Read-Write. Read this file to check errors injected. Writ=
e this
> > -		file to inject errors for testing purpose. Write fails with
> > -		-EINVAL if input parsing fails or input inject error code isn't
> > -		supported.
> > +Description:	Read-Write. Read this file to check errors injected. The =
readout
> > +		value has embedded 4 bits revision attribution which reserved
> > by
> > +		hardware. Write this file to inject errors for testing purpose.
> > +		Clean Bit[59:56] before write this file. Write fails with -EINVAL
> > +		if input parsing fails or input inject error code isn't supported.
> >
> >  What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme_errors
> >  Date:		August 2019
> >  KernelVersion:  5.4
> >  Contact:	Wu Hao <hao.wu@intel.com>
> > -Description:	Read-Write. Read this file to get errors detected on FME.
> > -		Write this file to clear errors logged in fme_errors. Write
> > +Description:	Read-Write. Read this file to get errors detected on FME.=
 The
> > +		readout value has embedded 4 bits revision attribution which
> > +		reserved by hardware. Write this file to clear errors logged
> > +		in fme_errors. Clean Bit[59:56] before write this file. Write
> >  		fials with -EINVAL if input parsing fails or input error code
> >  		doesn't match.
> >
> > diff --git a/drivers/fpga/dfl-fme-error.c
> > b/drivers/fpga/dfl-fme-error.c index 51c2892ec06d..a440bc09938d 100644
> > --- a/drivers/fpga/dfl-fme-error.c
> > +++ b/drivers/fpga/dfl-fme-error.c
> > @@ -39,6 +39,22 @@
> >
> >  #define ERROR_MASK		GENMASK_ULL(63, 0)
> >
> > +/* Bit[59:56] was reserved by software for error revision */ #define
> > +ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
> > +
> > +static u64 set_error_revision(struct device *dev, u64 value) {
> > +	void __iomem *base;
> > +	u64 revision;
> > +	u64 dfh;
> > +
> > +	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > FME_FEATURE_ID_GLOBAL_ERR);
> > +	dfh =3D readq(base);
> > +	revision =3D FIELD_GET(DFH_REVISION, dfh);
> > +
> > +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision); }
> > +
> >  static ssize_t pcie0_errors_show(struct device *dev,
> >  				 struct device_attribute *attr, char *buf)  { @@
> -52,7 +68,8 @@
> > static ssize_t pcie0_errors_show(struct device *dev,
> >  	value =3D readq(base + PCIE0_ERROR);
> >  	mutex_unlock(&pdata->lock);
> >
> > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > +	return sprintf(buf, "0x%llx\n",
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >
> >  static ssize_t pcie0_errors_store(struct device *dev, @@ -97,7 +114,8
> > @@ static ssize_t pcie1_errors_show(struct device *dev,
> >  	value =3D readq(base + PCIE1_ERROR);
> >  	mutex_unlock(&pdata->lock);
> >
> > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > +	return sprintf(buf, "0x%llx\n",
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >
> >  static ssize_t pcie1_errors_store(struct device *dev, @@ -133,11
> > +151,13 @@ static ssize_t nonfatal_errors_show(struct device *dev,
> >  				    struct device_attribute *attr, char *buf)  {
> >  	void __iomem *base;
> > +	u64 value;
> >
> >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > FME_FEATURE_ID_GLOBAL_ERR);
> > +	value =3D readq(base + RAS_NONFAT_ERROR);
> >
> >  	return sprintf(buf, "0x%llx\n",
> > -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >  static DEVICE_ATTR_RO(nonfatal_errors);
> >
> > @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct device
> *dev,
> >  				    struct device_attribute *attr, char *buf)
> >  {
> >  	void __iomem *base;
> > +	u64 value;
> >
> >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > FME_FEATURE_ID_GLOBAL_ERR);
> > +	value =3D readq(base + RAS_CATFAT_ERROR);
> >
> >  	return sprintf(buf, "0x%llx\n",
> > -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >  static DEVICE_ATTR_RO(catfatal_errors);
> >
> > @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device *d=
ev,
> >  	mutex_lock(&pdata->lock);
> >  	v =3D readq(base + RAS_ERROR_INJECT);
> >  	mutex_unlock(&pdata->lock);
> > +	v =3D FIELD_GET(INJECT_ERROR_MASK, v);
> >
> >  	return sprintf(buf, "0x%llx\n",
> > -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> > +		       (unsigned long long)set_error_revision(dev, v));
> >  }
> >
> >  static ssize_t inject_errors_store(struct device *dev,
> > @@ -211,7 +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
> >  	value =3D readq(base + FME_ERROR);
> >  	mutex_unlock(&pdata->lock);
> >
> > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > +	return sprintf(buf, "0x%llx\n",
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >
> >  static ssize_t fme_errors_store(struct device *dev,
> > --
> > 2.26.2

