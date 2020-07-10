Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574DE21AF33
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jul 2020 08:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgGJGOY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jul 2020 02:14:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:8969 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJGOX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Jul 2020 02:14:23 -0400
IronPort-SDR: CQIaZkqwaRBwpS0YaOXKh3hyKkJbnLSVzK7VUy3E9cU2VQNXsKSEo2KaDbq7bDclVz9j+XFkG+
 l+tHPa/FX+WA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="127748810"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="127748810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 23:14:21 -0700
IronPort-SDR: DYrjkeNDTDE+0PeUvDulaksFLuvo12c7J85VIUTELK0uiRi7Nz1XS0Icj/is35EfXwN680sZQg
 Dp9MAc6zN5OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="267632581"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jul 2020 23:14:21 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 23:14:21 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 23:14:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jul 2020 23:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJsgm767m+R8OZzhwHl1XNxzGhuSdKGhyfnC/UIJyZl+iQtiOGl13zSSwnHnMMq/El8kKHbr9U6ab37ZqSKL7GVqQDOSwMHyueqNO6deImzmzt6cq+aoXa8o2lh0wRnAskKIcq8n0EhGvW3G4nhcyTOEVvBY8Xp7hnlcnYVo7Ghhu7ouAP3U9S4GAyb7Q9YBB2bhKneITMpCLOjdAeSUYDdXAPsjI3Ume5OMtGXWSSq0PqE5YOnd/rDe9QB4jDDK/JkQ61css4424ljXEvhMcrRBDNDKOjF/DU1ZGeim4v/Ds/Z3VX0gXYRgiXDHkUEJYx7BsJ3w7ap3vAXTvmrNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vghefcwCSH88jKC69AJMZnndDh/2LId7LS7zeySOEb8=;
 b=HBHLieSU8MEM3iE+wHFiw8q8iFTU/8IyfczVx2V9K1Nd1NBTQIAgxvpdfPZ81Eiu2ZgZB1X7y5Hv1ZaJZpjr91TtF2mKOJ7WgjibO3s0hXVZ8+LOcqCSCB0Tupdi4tkYfNmztW/bONKh8bquSkjuRqZ+ILQuccbZUaD2dbQVdLpP9c1rwL0OkMa69Uk8+qj6KkFyH1mxCvT2x1XFEq9M1BPo9x6vH7HhtrWjPMcNHly6G2/Oh3ZCxcEjOvMYeCUz9rIJw0PUTx+k+oSysOiBM05D5423/nGT7Db/rjN4a2/HaUTFvvy2F+Yq85cA9+CTxfBbud824B5I2Nj3mERwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vghefcwCSH88jKC69AJMZnndDh/2LId7LS7zeySOEb8=;
 b=tw2TiHJ3NRiBmL8YWWoO72F5ATlShTZ20E2n2tzEMSq1elIabzDrz6BzoRgd/AvfZ43EQCI5VlMF/Cpv2Ip3DVtaMtEwYaI2gDroDeHFBH3fqQGCls5vizai04Ue2DHGrpd4nj59XZMWY/5vYc4JbcOMn3oO6ORrR97ubPoJ9U8=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3545.namprd11.prod.outlook.com (2603:10b6:5:141::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 06:14:19 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 06:14:19 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Thread-Topic: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Thread-Index: AQHWVcomDnRuf5Ios0uozSMTJLBb7aj+8y7ggAAJzICAAAjeAIAAMHgAgAES8YCAAAzw8A==
Date:   Fri, 10 Jul 2020 06:14:19 +0000
Message-ID: <DM6PR11MB3819BF1B54D64AD706BF832E85650@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200709093527.GA32541@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <2d7919d5-a320-58f4-5c9d-7ef868ad8676@redhat.com>
 <20200710052443.GB8689@yilunxu-OptiPlex-7050>
In-Reply-To: <20200710052443.GB8689@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e7cfd86-9ee7-4d7f-c97d-08d824987b7c
x-ms-traffictypediagnostic: DM6PR11MB3545:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB35451B1CF9C23EE9D9ACD1C585650@DM6PR11MB3545.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3t9EwkGoIckfO+O7tOWLdsZT/Tx3hn9oIuy8H9Kv4HsSs2ZSPedWrhuz+jvXlDtkL5eG5Z4fXN8JYFQdJfT46F0UQagbUP+V/Yf5WrirzZOSS4bzsYT+YmoT6e5TRCyQNHXP9Ub8AQ2mJxlJM0BvfRsLghXasy5hRtMi1GmXpLUGS14BgblGVHlfoixw6Q35E73EDHjL2TbBi+++R35YC/ljUFGbLB771QFuu+pn/BtBA3quJlehEv8T1Gzamthlk037JFPXAQwJWzfb0BFBFzgc8wUJcOZyduM/0U794tzlQ1wwkx+/oOeLUfUFvCd4nyjFPc0kw9mRmdXEJyn6rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(186003)(316002)(478600001)(110136005)(54906003)(8936002)(86362001)(4326008)(8676002)(2906002)(26005)(5660300002)(66946007)(76116006)(71200400001)(55016002)(66446008)(66556008)(7696005)(66476007)(64756008)(53546011)(6506007)(33656002)(52536014)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 15LgN48fABBac9En745C80uzRbIailKiQzgnQrmQFh2xEhXvRr8TvP8dDn24kbhWaeu7nnnXQSiasUGtNbd72BHUO8qEZVngX4+58ohqVFgdzbHkxxOxsiFxIZg09JkF7k5QZ36bzy96Uh7gP7I+B47TZjmjPIzp26dcr9uySHx54oa+fGfw4HmPJHF/YRIceXKLsqH3JvNe20R+atc+OLdl0Fq/rWvQdm7bo5DnDyIOjeamfWOoMPC6UewaMsV6zAmZbXO5P3HXXGj3S9oWI3MNMTbaKHawDqo6BAgco1c6ccbFhkLupuCChZy2RiIX7Kq6Yt2oMgY2tIMdomAiiA0KXQUTy41N9O25G+//ktVZX9HPo8Nz3lZjsfgKU2vkh/xQ9sSYwIi/hlvGNh5nmg9MRvS6GZ+OeR29il8PAaol3nyIYDN8L2UO4KVi8LpTnX6f2+Gt6LmR8SvQQ98zXL7/ylJDLMQUlYzVfYioci13XI4BH22s/ZjVHXp4Vtac
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7cfd86-9ee7-4d7f-c97d-08d824987b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 06:14:19.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpi1hs8lZD4U/diSJF3EqHoL53OI/DLUNqNbxnpmDvejOKsf8u4AlC2MD6TBG8wxJ7lHj5rMP0z0wPLmJL9PNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3545
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Thu, Jul 09, 2020 at 06:00:40AM -0700, Tom Rix wrote:
> >
> > On 7/9/20 3:14 AM, Wu, Hao wrote:
> > >> On Thu, Jul 09, 2020 at 05:10:49PM +0800, Wu, Hao wrote:
> > >>>> Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC =
N3000
> > >>>>
> > >>>> Add PCIe Device ID for Intel FPGA PAC N3000.
> > >>>>
> > >>>> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > >>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > >>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > >>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > >>>> ---
> > >>>>  drivers/fpga/dfl-pci.c | 2 ++
> > >>>>  1 file changed, 2 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > >>>> index 73b5153..824aecf 100644
> > >>>> --- a/drivers/fpga/dfl-pci.c
> > >>>> +++ b/drivers/fpga/dfl-pci.c
> > >>>> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev
> *pcidev)
> > >>>>  #define PCIE_DEVICE_ID_PF_INT_5_X0xBCBD
> > >>>>  #define PCIE_DEVICE_ID_PF_INT_6_X0xBCC0
> > >>>>  #define PCIE_DEVICE_ID_PF_DSC_1_X0x09C4
> > >>>> +#define PCIE_DEVICE_ID_PF_PAC_N3000 0x0B30
> > >>> Should we drop _PF_ here? and also do you want _INTEL_ here?
> > >> I think we could keep _PF_, also there is no need to support VF of p=
ac
> > >> n3000 in product now, but it does exist (ID: 0x0b31).
> >
> > I was wondering about the vf id, thanks!
> >
> > >>
> > >> And add _INTEL_ is good to me.
> > >>
> > >> Then how about this one:
> > >>   #define PCIE_DEVICE_ID_PF_INTEL_PAC_N3000	0x0B30
> > > I am just considering the alignment with ids defined in
> include/linux/pci_ids.h
> > > So drop _PF_ before _INTEL_ would be better? : )
> >
> > To be consistent, all the id's are intel and all could drop pf.
>=20
> That's good to me after checking the pci_ids.h. So we have:
>=20
> #define PCIE_DEVICE_ID_INTEL_PAC_N3000        0x0B30

Sounds good to me.

Hao
