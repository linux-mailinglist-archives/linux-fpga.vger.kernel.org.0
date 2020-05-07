Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C11C82B0
	for <lists+linux-fpga@lfdr.de>; Thu,  7 May 2020 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgEGGnD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 May 2020 02:43:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:57934 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgEGGnC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 7 May 2020 02:43:02 -0400
IronPort-SDR: ws82lZDSY4+lkCqbj5PIt2kKgbiSkFKDtMA/1vL5lcCk5UDfkjKBUzZM7CIcmOmImLQWXkAULC
 YTVCZssu/6jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 23:43:01 -0700
IronPort-SDR: H+cehh92x/yJ/BzVM0n8NSRARaTcFfaQyAYeU+a2Dr0BGl/mhhTAP6Zt5wik9zE197uVDQFa+n
 iMd5x/AI3LbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="296437219"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2020 23:43:00 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:43:00 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX154.amr.corp.intel.com (10.22.226.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:43:00 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 6 May 2020 23:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlHJQC7qz3Z78SI72eVB6lOivMXPIW2Y23Km9BWhuhTKiJs01KQkYUFaeBqjfosGJ4+YW1FvRw55GpRi5ofOsom5CUmEZQNVwjVfmmz2qZc12PAFgFF/rWXetMUkQWvj7rx7gufU93nC5aNqD4UNXBPrpiRvLw9BL7xG1QFGk0hs3UCuxQ+5OdJIHwj+cc8IXgw9H1pOuOwOvMHZii3/MPTaJrL/S2Pb3xQiwDWaD70TDqI6b6g1sHe8ppoB+HIMbJqbhuFzhRUK3987K1Vbw8ia/TNHfMj3yi1d0ebMVHAGGkj9gme41aDTknnr9TVb6FV70ORVwBXSBaC0lNWRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HExaJOc4giryd46kdYuVoA7GPqDnFvti0JtX7qciXZY=;
 b=Ggm0lpHy2Yv+haxHfB9NnEor3vuJyImVQId+FAwYDjLELQl3hci9B9mSJbSOeacs5DCszS6TVrhg/LPA40HOqq7symnGLpUMIS4/Mdb2B8jlpPOrD1KlJoTIzVhUbOGURmrDfmidocWzLZ18JCnSWSvZcM7BZdbtUHNj0FFvEstfCv+1wZ8av443sSo0sFkfJRCeB9P8vUwevo0C9a/vjj/f8Mh7/nHD39sQagByeukQJSHjG7SaAbLfGRlyZpnDdYjB8AoAYrJfGb2kDxMwxCD+p8zvrDBpc3fa+tjw50N/PC7LOdwLgivnhHsA0eUzMTHrzSJ/L2kcMqfOq+xjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HExaJOc4giryd46kdYuVoA7GPqDnFvti0JtX7qciXZY=;
 b=s5qV7/wISA98MhaHc/mE6WzJ0R9aThRCCBOCwFp6Ey5ys72EjPKyioAjRs+ZLIVVEDo3J5ZpY5OUEbXXNOHvM60jMERQGUGMmEplvbWSIbsywokgSG54ogJTZecKbpvgIDaNA/3Inil8KZeIuVdsbRfn0owOt1KcKvRNQdNBrHc=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Thu, 7 May 2020 06:42:06 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2958.033; Thu, 7 May 2020
 06:42:06 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [bug report] fpga: dfl: fme: add performance reporting support
Thread-Topic: [bug report] fpga: dfl: fme: add performance reporting support
Thread-Index: AQHWIIVTb2xNTyPKpkG5EQo3Mz/uRqianuGAgAGSrEA=
Date:   Thu, 7 May 2020 06:42:06 +0000
Message-ID: <DM6PR11MB3819C32CF618A08A0901678885A50@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200502132419.GA41486@mwanda>
 <20200506063123.GA22708@yilunxu-OptiPlex-7050>
In-Reply-To: <20200506063123.GA22708@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a052eae-4449-4eec-669e-08d7f251c28c
x-ms-traffictypediagnostic: DM6PR11MB3291:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3291AE9E3F054FDED7BC510485A50@DM6PR11MB3291.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01xnVpyjrxanGHNrKX65F9kjT0MtkQS15o1dbARMnof2zSaOGrx1w0YfD2myBvAIRN8kDI70EozNK0DyrFuHEr4dzNYTZCIpMph/YueRc1Sa/6TEtAStjqrSqMS14BO9F0bs1tXxjqtyUZHQuGHJE/1Au6qtBp+GTdHDhpHwNLVa+xwTuhaTQsaMKWArK6gg0p1laz97dzOmJdOyemVWaalUdRQvikg+dUf7hVgkSNJzcEd0rp/DiyzcRS4tuQsUge7ycTECM61+7pg4dgUbFQruDHpXwZ4oJ4Hm/GUTKUQ1Gld9762F+PPaFk/Em9LWk9EKwhm+9r/aPiNRc4o/fox9dRpwhFHtkkJ0Av4xPtEF9nPmj2O91brRSOFBPkeubMt1ZD2wS9jEvxyAbPDiJJO6gamNDYorTstEerRB+Q7jze2QJNedyEJB+5+JcaKCQKQQT+98GUnTvuCPeci9EdE694bxROOVMJqHcQ/E8URQkoN35JpA1493mVpPp2oxPDd90oPpl1mdP3XKAgm4qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(33430700001)(478600001)(66476007)(110136005)(76116006)(7696005)(64756008)(66946007)(86362001)(66446008)(33656002)(52536014)(5660300002)(2906002)(66556008)(316002)(8676002)(55016002)(33440700001)(71200400001)(4326008)(8936002)(26005)(186003)(9686003)(6506007)(83280400001)(83320400001)(83300400001)(83290400001)(83310400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1Cqe2oGoVBDaX89FYaOdlYwAP7Rqr73KfNb4H0lBygprI07XLf12vp0+HhvyFT5WHUuHOIa8kURTAms+UatzO95e+rmgp8qT6JNIyDATvCKHtyGNIXDnZ0W0hyom8P4Twp6bxsBlrBGIvEYoqRMJ8IbhmetYpuRjaYGDYuqcSIbJA2Y3ShiL6fl90oH4jPCSB+pyXOlQzLF3/AVXpwlFTbFkfzTQR5hzAx2jdxe+zVYZscnGOW8t9+Eeh40EiVas/7O+qm9Aeql/NE38PQPxugSCF1mM5XCGYtrYA2ObzEhg3kxk5h61DvY270bEoo7RwfUw7W3CeR+2GgCwF7zFouJa6z6cBHyxJT7dNb6s8ZyD+YYlkCHBob517HORdfvyPSfYHPAfnEIWwR1qZuiSkik3e6M3rvjLbyy+2Jnq+I4lMUZIqgCz0tmVmPFF1ERZmkEVcZs9wWIpsQzkU/EX4SfDTnxfRxOUBh8W6DG/RDKzra2RqtIwQE5or6buXsidyvZu821B3Ay6iLkxy2E+keZmWeuAHJtZ1+JPhw/XAPI9EmV+8c0/mQYwxHmQ0G/FB829UYv5SCvrVmugzgEQ3M8q7j5+mjmacsIlaQxtgce2MknFUe8meAVcuTRwIDsYbcuB1CsR5ytm/wm5u15o7gZDLnmJh9mj1O4QF2aPfsaPafIpxTBp7TlbTHCD4IarthGFKyARbLlb1wF5peh+OOgBr70MZ9rjk6Wlxl9PWW7I/nGjwcPmYXnK8bWkWb69DF+LBqebNY7QLFl0iaC0WHgT181CWsxRS63pOQ/ABOc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a052eae-4449-4eec-669e-08d7f251c28c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:42:06.4639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYusX11vrsHJfHDrnipDaMZQilfA1W1ZKOdxW5Lymi9ykZrw18R98wjSb9lMl1YE8twbplZMbQeC1iyDbhgQ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3291
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Sat, May 02, 2020 at 04:24:19PM +0300, Dan Carpenter wrote:
> > Hello Wu Hao,
> >
> > The patch 724142f8c42a: "fpga: dfl: fme: add performance reporting
> > support" from Apr 27, 2020, leads to the following static checker
> > warning:
> >
> > 	drivers/fpga/dfl-fme-perf.c:948 fme_perf_offline_cpu()
> > 	error: potential NULL dereference 'priv'.
> >
> > drivers/fpga/dfl-fme-perf.c
> >    941  static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_=
node
> *node)
> >    942  {
> >    943          struct fme_perf_priv *priv;
> >    944          int target;
> >    945
> >    946          priv =3D hlist_entry_safe(node, struct fme_perf_priv, n=
ode);
> >                                   ^^^^^
> > It doesn't make sense to use the _safe() version if we're not going to
> > check for NULL.
>=20
> Thanks for catching this. Will fix it.

Yes, it's not necessary to use _safe version here.
Thanks Dan for reporting this, and thanks Yilun for covering this when
I was on leave.

Hao

>=20
> Regards,
> Yilun.
>=20
> >
> >    947
> >    948          if (cpu !=3D priv->cpu)
> >    949                  return 0;
> >    950
> >    951          target =3D cpumask_any_but(cpu_online_mask, cpu);
> >    952          if (target >=3D nr_cpu_ids)
> >    953                  return 0;
> >    954
> >    955          priv->cpu =3D target;
> >    956          return 0;
> >    957  }
> >
> > regards,
> > dan carpenter
