Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CB2CB944
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgLBJl0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 04:41:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:23623 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbgLBJlY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Dec 2020 04:41:24 -0500
IronPort-SDR: O/3BCaxE91i/Yejhg909RfpjaDgJfhMdEgQuLbvRjTdhCDS6m675UJnjsZdyzrB3KP+kVgQBaV
 QssLlJBkaNiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191201895"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="191201895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 01:40:36 -0800
IronPort-SDR: VixqcqpiV0CsGAxMUkf3ODGhz6VQ+Uz2sJ9eGAkGQtN6js7JayAosCGJsa13ag4draVr2t0ezP
 EssV2kVwoqbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="345808168"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2020 01:40:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 01:40:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 01:40:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 01:40:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 01:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqVBobqSEhJBq+o48GSTbmWEsGyvIZLzRzdqr6pN1O8jyFilXGCbdVEpUb7D8rUi13MPMs5xMmE7/Yl8oQukkz2fjlunwttfCl9J5FqBnwHm1FFBpVnoAcuqRDrSCrHEq/tpED992w21SL/GF4lioi9BwIhJXr/9RHDVMMM3FahMEggUA0k/DB8alCsj23wY31tb3V5sD0hSUJkMv7/+z6MR1Y8W4TpJ4G9NOn6vuR4IVppwiSf3tnWM1YVpdNq6e5aNV/52pBCF2zYl28+hq6fijMiZBvJMkjpmyeMHZCASm3N6B1+7KdVfwHUEZDbRvw59PH7SEz9grQHsttUjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pLzVbQ88va+IwtPasWrZX0lY+qTMJcCXLQp0atxc2g=;
 b=PjQkBN1s1x3Xh6scq5+Ka/SdaS/GhsrGXJZTxNJw6ic5z8WJRRL1omuDUSpbqNzX6ZncRZZYsyPTMbiIEIkMXB+SIqBo1FeGblERNEr53bt2w3C9tEdAUTgNWYlsxhwEjr4fOVJIStrsbHL5IuSz8NXrMwZOLMnpzBm7LZmmRo0SPltjnk+mXziB3j5WLTBHaubMwVt8H+qChtWvgKxctez/nWGIA/ROjd1vdStLLVfzF3U+LLNsn30JHu0WZBoxvHfuJbEM9/UfqLEY5MXViCc2JjGcZ4qm6/Csbk4SpyR1DW45BNuYFqqwwwenIiAUH0N0VXKVAn5vQGDEYnFsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pLzVbQ88va+IwtPasWrZX0lY+qTMJcCXLQp0atxc2g=;
 b=i+IAaZdx0/LOggLjppRUhVZ9UIUIwziovihz3zX9d4CXNU/lQYYSHdydPd1rc2DSRl4VSAV+K8z9ixMlu1jIq+c8NO0oi7t8q2rbw2oQjmS62kGXjdkE7yVKUqVPV4WeW0FZ272gd2mTH3+Jah2Lpsvs1uly0/CIvf4J/Y/g/KM=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB0073.namprd11.prod.outlook.com (2603:10b6:4:67::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 2 Dec
 2020 09:40:32 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5%4]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 09:40:32 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
CC:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
Thread-Topic: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
Thread-Index: AQHWwnpOqjhoM37MKU6ujI2Rfo8RvKndD8WwgARhwwCAATDggIAAdlWAgAB6kRA=
Date:   Wed, 2 Dec 2020 09:40:32 +0000
Message-ID: <DM6PR11MB38199A96C6871F1B041694BD85F30@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com>
 <20201124155658.700976-3-matthew.gerlach@linux.intel.com>
 <DM6PR11MB38191D8C5E27E6E04B8DAA1A85F70@DM6PR11MB3819.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2011301614040.1050045@rhweight-WRK1>
 <X8aR36hGoV9SsPDw@archbook> <20201202020003.GB22103@yilunxu-OptiPlex-7050>
In-Reply-To: <20201202020003.GB22103@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50dd4967-08c3-4843-011b-08d896a6500c
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0073F083CF6A4EF56E74B89485F30@DM5PR11MB0073.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sqpqVaZw0yD+zpBRyV0UdNRw7mmqChpz3FejHH+JYcsYIc35laz0fe3l6NXfvKJECK4l6dMMpBPi9I3sFjwKV3JzoYZ++LfWDW3CaaEuCwRn4X6EM1ZpNHoHT+DsHJyVSfYZqEpqcrd8DS7FtLsXQXusx5Sf5bXsOtnz8kx20j3n5GGnM0FmtNLVySQeLBK4xgvS0nRQTvU1rjby3Eyuwdfj5PqqRBhuxPZJrU+Rzdt106XbGFgEx+qrirElYk3ar7lw5xQ9ELCAyTE+3sQNY++xfmgjOJTDvhzd5yCMYIwKgeZam8s7OUc7CaVOOLqW2Qg0ZBkdW5pOE59FaNzZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(55016002)(2906002)(86362001)(76116006)(9686003)(186003)(26005)(33656002)(71200400001)(478600001)(4326008)(8676002)(8936002)(6506007)(7696005)(66446008)(64756008)(316002)(5660300002)(66946007)(52536014)(66476007)(66556008)(83380400001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yxUC5ZkgVbvYymMZmWgYgEYZ9qHJhf4FfXEJNT67pYGAXz92kzSSeWoorl0P?=
 =?us-ascii?Q?rc0KGS0dIBIsvQIvxWHOrxLbUpZhBTFdt1gCsbMaarhX12gKH+mbSTFdsmBX?=
 =?us-ascii?Q?gSG/mzt4Rki0XCm3hAmcXRNOqmvPJqbWWw31iScmpRTI7lD1hQDBCaW5uL9L?=
 =?us-ascii?Q?HSEm1YR0HaDXC/cvA+SM5/txgBoGha1ArnxaGrFOKJ5kJUouFHYdYpIG3j0A?=
 =?us-ascii?Q?OJsfR8ZJsvSo6/5vj3NgYIfaVDKfKltGkN2yQjT8ElQMIkP9fQcTSCiwNhaC?=
 =?us-ascii?Q?yj9vozmYY0T5uxk8b/0H69EVGjbW3wOfor+VzVLnuCCkGiYXjEkqLCpiaFil?=
 =?us-ascii?Q?2YYvQmEAmi/OR7nyqtWrXDBRsmZKdxI8l7SMUVetFlwWp0ZrqdS/Xu7ZxcBD?=
 =?us-ascii?Q?8vx3Gcg9dAuLglMWTkAtK+tf3OqsKeMwqhk/twr0hc5Svdux4V+1y/aNDeJj?=
 =?us-ascii?Q?MLt0l8xN9aee4GcX5JWSFBaCUn/mGrWn5xv4MnX4OYELdi28BA0cpSaFvqZc?=
 =?us-ascii?Q?CQ+xP8dcRiXfVi7HvsyM+/t0MkhZxn7/oD8n/DyH3KhypXRWJt7Qt6lZcGZ7?=
 =?us-ascii?Q?9I355x/tunbPRNUN9K4Bpz3nAPMSCUyqkRxfCnuZ26Tf4f7/xZH13/Qt1iUX?=
 =?us-ascii?Q?U5cZkyFn7ADgQLW8btQwwi3cFkuuX2WUOPEOgSM1BqxrLApM6kMdMHVzlws3?=
 =?us-ascii?Q?YU6VQkIvbajRN+wQyiCsgOFxZWSoOufkY7cpmSNJq7Vo9pTBA1rys/mVnoEX?=
 =?us-ascii?Q?Ad+37FvQXNwCZ4diNZHsjMZFJcHqF2DCDopW3eFUw6dQD+vmzBk/4+4X2oC/?=
 =?us-ascii?Q?aLecux6KaxK/AbegKE3RuF+CvP5Hr3zyh+YcpeWS9BCKrVFuas7Cp43kHJOs?=
 =?us-ascii?Q?1JD4a0Oiiw/UK4VXtvgBJIxnI8k6HTVJ7vT4jAnMpUORumXmrqhmPJ1fNCsJ?=
 =?us-ascii?Q?cw33t3ZFPTy6/0ohsgbbQWXKKFhbOEw24+jYyfHDqM4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dd4967-08c3-4843-011b-08d896a6500c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 09:40:32.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDwNqpXhODxqkIr2TgfNXEKdngW9pbqFLdQc5HcS7O2o8W5K96dbvxaIxs4nIPscGO05nGkc4itgHpJreooogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > >
> > > > > +		}
> > > > > +
> > > > > +		offset =3D dfl_res & PCI_VNDR_DFLS_RES_OFF_MASK;
> > > > > +		if (offset >=3D len) {
> > > > > +			dev_err(&pcidev->dev, "%s bad
> offset %u >=3D %pa\n",
> > > > > +				__func__, offset, &len);
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +
> > > > > +		dev_dbg(&pcidev->dev, "%s BAR %d offset 0x%x\n",
> > > > > __func__, bar, offset);
> > > > > +
> > > > > +		len -=3D offset;
> > > > > +
> > > > > +		start =3D pci_resource_start(pcidev, bar) + offset;
> > > > > +
> > > > > +		dfl_fpga_enum_info_add_dfl(info, start, len);
> > > >
> > > > That means everytime, we pass [start, endofbar] region to dfl core
> > > > for enumeration, if there are multiple DFLs in one bar, then each r=
ange
> > > > ends at the same endofbar, it seems fine as enumeration can be done
> > > > one by one, but ideally the best case is that this capability can p=
rovide
> > > > end address or size too, right? It is possible that information can=
 be
> > > > added to the capability as well? then we don't have such limitation=
.
> > > >
> > > > Hao
> > >
> > > I am not sure having more than one DFL in a bar serves any purpose ov=
er
> a
> > > single DFL.  Regardless, I think the consistency of just having Offse=
t/BIR
> > > in the VSEC is better than adding more infomation that has little or =
no
> > > added value.
> >
> > Agreed. Can't you just link the DFLs in that case?
>=20
> I didn't see the value of more DFLs in one bar either. So I think we'd be=
tter
> document it.

Yes, it needs to be documented well, otherwise users may have their own
choices, e.g. link 100 queues together by modify DFH registers of the
queues one by one, or just have them done together in the VSEC. I am not
sure which one is the easier way for logic developer, but at least we need =
to
document what driver can support.=20

Thanks
Hao

>=20
> Thanks,
> Yilun
