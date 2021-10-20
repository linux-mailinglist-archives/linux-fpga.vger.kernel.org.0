Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB5A434462
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 06:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhJTErt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 00:47:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:65535 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhJTErs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 00:47:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="314892394"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="314892394"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 21:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="483566784"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2021 21:45:34 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 21:45:34 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 21:45:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 19 Oct 2021 21:45:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 19 Oct 2021 21:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kci/IaL57xkx8tMkgiTEP3yKP7h2BDgYS6yFoDVfbCuTBekkyYwmV3IxCXzf7VC/L8OSwX2RfZG8Ula6eQbZnahMUOhv5er2HpWICaqz/0YTGjXM3yvT/jCoMr405GDihfR5nCjwDwDmnHLJjvljMz6uRecgGsxn2R/lUw+vtMOk0h6BJMKgaewhTQnlmNSG/rX9mi8Be1ODPhis1JfLoLTHG3WH/6Zb5dYAsSpOBYwjM9AioleOKstQ7HTou+cYf84kzRKt000TSgkmFb0AclNLWzoBWRzdVI6TnES0vXM4Weg3c9djJAj4k/ApLgg3AbHdwV5WNIDq/s/+usfuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4E93FWCvrHsdrnuKAWZdEZj48kbE38pZ1WFuJCX/Fs=;
 b=VRZrkkRRTYjeNmlDAxEdKQd0RzW0sQVyPIJt/8fobbjamus6PR9exLjcyUFB58TxJ2iByFNu4QQX45RgYGZomT1+pVFqck7f42X27gNUUcUpxIVZ9a753TjYVnkFQAC5qnxRUFaP6JFpU/073LdkMS9qA9S7hmLWUh/ZcElJnOC3W7sM+etM6po2d+qqAc6qVOK3KFESftQv/D2Mgp5Z9tQmz0rt8By2bp7x5GtAr99EvxvbpAnitKId3rqDMOCNbozDA8UCTXPD87kcWrFJCg6HO1j9Y/GVIDbm1jNNECUt/fmooaCcQzCHzmrwXAf31DWkmh4faU5XvfyyxHEXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4E93FWCvrHsdrnuKAWZdEZj48kbE38pZ1WFuJCX/Fs=;
 b=DzMlFz7DYrtpVi44QL110E1f4R2jgtyenSH9xsZX7yZgzuhbg867Hoc8rLccGF3Suyi77SZqLYJC+1YlLYRJy62/Na4sIjGowcrXwcu3wC0y23wkK+Xtlh2FUgnBsmnCRuaJydOafrjiaFM4jHEIK0k9vraFknqXjvTqahG4JJw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR1101MB2073.namprd11.prod.outlook.com (2603:10b6:4:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 04:44:43 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::bc8c:4526:43a4:3104%5]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 04:44:43 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
Thread-Topic: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
Thread-Index: AQHXxT9HeMr2I/hZYUmG/Mg0WNK+PKvbSqRw
Date:   Wed, 20 Oct 2021 04:44:43 +0000
Message-ID: <DM6PR11MB3819F29DF7B20FDED6DC814685BE9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20211019231545.47118-1-russell.h.weight@intel.com>
In-Reply-To: <20211019231545.47118-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89afb223-a2d7-4f12-36c7-08d9938455bd
x-ms-traffictypediagnostic: DM5PR1101MB2073:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB207344E64FCBDC62C19BCA1385BE9@DM5PR1101MB2073.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxCwBUq7esCS80FGcxiunAlTMOfxxwT4c2gUNS8o2dDasqucClYiuAoSh6uRnN5Lj0LtVvvdOc3YJiWSjlRARsxGZeUXIJ11EKrPlA8g7VVW//nLLb9n7UQwgjnKNOXAq/Rwhx3pWD439KJuvBwFxyuakTvSIV4WccIyA4wGyCoMdPywW3A58rUCYVinzu6pxkcRnbit4t7Q9R9/ir9ZQDwwdN0gCmQaSri5rkbf0nKgEYMeoclUlKAokqjlPH8+ivSCBq8qYgaI2zoLrPGDUunJGke3PPYh7acv9tnnQ/fSFMwYyKmaT2xatYlHy54j4Epc6RKQr+giBVKXWYaw3kOczzI6Knrll8073OicpZHwxheSJL9rmakpT8sKUYWeKXag34SlxKDhTb6t+kCqJRYtbn8eBZUEOPpmPZvYLKT4s4Hy+3RnLCrqR5Wu25QYt9Na2uLmWr1m9cmAT5ZsZmLyLZls5/CEB+LEF99iifyu2zI8wgNxFLBTCR2Y2UoVvoNWQDohgQYjsowoi7pAjJL5PY1mTPxdZ/hQ1KlnENgaxmCyENF45RqBt1yBdAT9Pd1H/HOpcUcbhQIrN2J1KR+WrNibUJIm8ohKjnbMZWsWaS6p424Z6QheFm2gS93nPhbM0v9txOGwTDDjshwm2z8UA1g7wXPMbRuxuyj9erb/L1v1CeAaR7iLl6YhLbAO+8CdELTNOtTFNHSpWFNIwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(316002)(4744005)(86362001)(55016002)(2906002)(508600001)(8676002)(76116006)(107886003)(9686003)(26005)(4326008)(8936002)(64756008)(66476007)(66946007)(33656002)(122000001)(6506007)(38100700002)(66446008)(66556008)(83380400001)(38070700005)(71200400001)(82960400001)(186003)(52536014)(5660300002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WOEF//OppMMMNoeWXvffoddSE/WcsDhHOX8DrRlqzcvPWiasEyV8L8o2Xmdj?=
 =?us-ascii?Q?qPNTRiLALcxwL6G7l8p4mfhPSJJvXSKZ7P7cRzda6hFeyhYakvxMZ1ni2aI9?=
 =?us-ascii?Q?Sa/ZN8Pi/bKJehsqNOrpbq+IUKW6Ql3gE1pJtEvMeMbYMancemMJ7md/8xJx?=
 =?us-ascii?Q?fDPqcMpx6YL9WICgxUmf3/AYCsJD9pPy0NoHm5UTLX1ASoIJVNqlxG77fbPW?=
 =?us-ascii?Q?lXbzfnaR8iVLv5JBt8AG5qkxQZP+iL7RlqpjpPBe83gCxJrd381cQexYlwXX?=
 =?us-ascii?Q?j+peB4ZyLh1LdaxHZDG3FdzcfnWf/zi2N9p7K4vlwK16P/JXmCxaf3cbuUjI?=
 =?us-ascii?Q?yNwQNAWmC5cGWFK8eV/5umtFyA/rB7/6lwoJV7pSc4lh+0/WyaJpLCm7Ne1A?=
 =?us-ascii?Q?As8vJJ7IpkBT6VUdzKlOCck8XAxPwJbtjgHnxPcMTh88wriM+WVb94LWwzFW?=
 =?us-ascii?Q?KO3N1qhVLOi6DitK/tXtSLsMrD9ohBom8IvkyFut0b1UWlS1nDLqriepy4qh?=
 =?us-ascii?Q?TooDb4dgjUL72ZB+0mJdQY0bS3j/9WNpcnozHfGk64fk83cQw9zH5r10BWDy?=
 =?us-ascii?Q?YrO7WiV5cYHcCao8BCBgtHBwnkZZbAc1YrBUbEgDvBpVFg7NBonV9wW/ErDB?=
 =?us-ascii?Q?/0FDs+Pgzrd0bWIyMddYxM62/ZoSdflMJYdMVP2SovdII0878/gdBuyfn45n?=
 =?us-ascii?Q?Fws6PcH+9oWGEh4MxiWu7xmfkqHMHLcDdHXjEISaBp8nGbTWFQr8mNQ0D9zy?=
 =?us-ascii?Q?BcOSs1gYsDQ6zi3RHXVHcEwctgb9pZboJ+5BTQEDRLpwNCFG2wNsACrght/t?=
 =?us-ascii?Q?BKEBVha76nj2/APljoO6hqVoKAJknsSSd5HrrosG5YLsmpXx5EAHi6qPQ4VU?=
 =?us-ascii?Q?mqWcialxffLX1ioGLuu2iN3ku4mZdo9QK21PBOsMuufNr0ryr9UM6+ZXq3oZ?=
 =?us-ascii?Q?86e/hzNwMwiw0lAfkYLCvPDkuuc9xpcg8PrfuZPxoYY3elbUePv6EYyLD/Vn?=
 =?us-ascii?Q?vS2m8p9y5+UL9xu++V/ggTWrFRwu55XIAFo31uAYNXXmHa8viuI0IwI6hEFv?=
 =?us-ascii?Q?fF8RRwbHQfcotNpIvzKmTKYlB3gIVS5cbPSAjU9neFLk9EHcsLl7P8DNpG6Z?=
 =?us-ascii?Q?HWEGo9RJkoOwo5it8jCui5EumBGH47EQpWOjhe+B+0unLkrcrYAb6WEES5t9?=
 =?us-ascii?Q?tu752Pz+BgkMCiCA2IPcSfZk0PfBdy1nzgtdJN+DzkX/JH6k2uJMGOoJgeq5?=
 =?us-ascii?Q?Oboez/5IpuQgTbt0xNxbmqfxsNNVrg6hEdrn1G7zhQybuZjvjiUYRAX5Ys14?=
 =?us-ascii?Q?CCQ8RwJrNvuJFZJqXjBM+gyN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89afb223-a2d7-4f12-36c7-08d9938455bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 04:44:43.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kwQQQxRcNGOjsQsEuBQZ8xw6qvcZgM0KvnMxmIC2iSUTaoVyOhPqz7on/DrbEsOUYjgO1SiKbp/ucBhzduUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2073
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
>=20
> These patches address a request to log and clear any prexisting errors on
> FPGA cards when the drivers load. Any existing errors will result in prin=
t
> statements to the kernel error log before the errors are cleared. These
> changes specifically affect the fme and port error registers.

Could you please explain more about why we need this change?=20
As we have user interface to log and clear errors already, is it a better c=
hoice
to let userspace log and clear them during AFU initialization?

Hao

>=20
> Russ Weight (2):
>   fpga: dfl: afu: Clear port errors in afu init
>   fpga: dfl: fme: Clear fme global errors at driver init
>=20
>  drivers/fpga/dfl-afu-error.c |  26 ++++---
>  drivers/fpga/dfl-fme-error.c | 128 +++++++++++++++++++++++------------
>  2 files changed, 100 insertions(+), 54 deletions(-)
>=20
> --
> 2.25.1

