Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04120CC09
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jun 2020 05:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgF2DND (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Jun 2020 23:13:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:24054 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgF2DND (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Jun 2020 23:13:03 -0400
IronPort-SDR: xzrnEASyAopVXjjZ1OC8JFnqj0tVXQvxAHNiTSZW/omR+Q9IHaxoKt/jEEiYK6td/S23AeMKw7
 oQFRvUiVatkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147447392"
X-IronPort-AV: E=Sophos;i="5.75,293,1589266800"; 
   d="scan'208";a="147447392"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2020 20:13:02 -0700
IronPort-SDR: wKZBbqRu1UP5EZE0obY9cRYkJ4cXkLWIsxqdMRsLq7EPzNsGpj/PuBm26fuczNRjhvgf2R5YZi
 /MuDBLyAMi5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,293,1589266800"; 
   d="scan'208";a="280726667"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2020 20:13:01 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 28 Jun 2020 20:13:01 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 28 Jun 2020 20:13:01 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 28 Jun 2020 20:13:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 28 Jun 2020 20:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWYkF+tiGkABi4FjX0bViKZ8cewjAzXqVki+0Ng+3xU525U+U6hxoD449x+ZF6me4XaibDGVm/EhqtvEMYyjudRT13nu2eAMm0K4gObqakt7l6c8aa6KiVug7SQ27u6VOjbGXhEShya9sFEpJ9agLHlQ67aVS103IcywAwbai7pNv6o0kbFyyiBB2pLu9DhR1yGvwz3ao7JS8xSoowWOuQKKaWnTQU0nse3/tSDgeo35/fbPS4zhceAgEf7OLkBNLWz/mmJUP9LtbU9ij9OrMTE3dHCDfDvU7XlnbQJIbheF+EilucDEeYWGIOP9yKPUAAs+6rNE1xki9wUzget0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53hvZBG4WTi80KKRIXmtZOMIZ4bS6Rkw6LFZCGkXIZM=;
 b=A/whJ+xA9iOY4ViDSjmkdPzAmX/bN0823M0CMn6Y6yFlkpcxyn3F7xeyMSqvawdtqpwUsyFpl8Nb/1ZBodlaJWCSdLeds3kraQFN3lNEpEV5Kzx5IiWvtTqdiTfDButvVRrdqGkiJ1jef8R+CaZlz5dxkOcN15xOyUzdSWXaKROb2sDKAa6DMrDxR6rNehxp7MVUBzZ7PVzeZOMUiSpvhuiOireRKRRF41XFU5tAntZu1oveGt1hRXG/L274YyaHbDRN8nfwAvwTQnqCrLlwUAUxkBX+sXM/GQa/HkRO/YEC4b/+EcARbUeL0GFEluXToqr9q2HYhxIvFyLxRVvhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53hvZBG4WTi80KKRIXmtZOMIZ4bS6Rkw6LFZCGkXIZM=;
 b=n16erAUtNKEXBjf+sW5dEwR1n/+KTkbhFmC8scowrxtlDd8I8yCiVspGTQofMzmf3sb/dTSGWiF9ZytGNNdCr5cj9aXUic8xZj0+1YEey3m1cYtPEP9dZTZNlNV6K/z0MaefmsJoTwig59xNNYCB4Q/6bRXknqs9a+m/UHbikoE=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 03:12:53 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 03:12:53 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Thread-Topic: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Thread-Index: AQHWTV9tEB8rGujJlkC0kwtfRn41f6ju3KoAgAAFiMA=
Date:   Mon, 29 Jun 2020 03:12:53 +0000
Message-ID: <DM6PR11MB38196ED29A3E0BBAD7B246C1856E0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200628151813.7679-1-trix@redhat.com>
 <20200629021924.GB2620@yilunxu-OptiPlex-7050>
In-Reply-To: <20200629021924.GB2620@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2704990d-153b-47de-2885-08d81bda504d
x-ms-traffictypediagnostic: DM6PR11MB4628:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB462817962765567DCB07260F856E0@DM6PR11MB4628.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/EtReSQZmzlknT8Y7ZzqSxR48EWasBAdRXgc64cKreIZgWKH5I2JQyqORsnIeGlHSu1wUQ79rnM6vfWNRYJGYdIO76fLn/d+Nd3ZV7UKpW6tmZJ5clpAQoKFKsi+27JpfiRNsqXQuiQ+wBjO94G513kW2Sokyl4ZXNBvCnKPEhPEyThTGmmVQxlxDCqLC9fQI3nKEnk1KSCJwxf5gPI3ImMxXeTwMfPPxLvZ81UeBDhrB5a68E6t9wQQZsVRnM1/By4l6AGkI5Mvcewguq7me0VShI4vtL9d+9CGeSWWbq9+C4TcmfdQiNdxLN8suJoTdcSQzWy2ugEiCWaZsx5bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(71200400001)(83380400001)(7696005)(55016002)(4326008)(86362001)(9686003)(110136005)(53546011)(8936002)(316002)(478600001)(54906003)(6506007)(8676002)(66556008)(76116006)(66446008)(64756008)(66476007)(186003)(2906002)(33656002)(66946007)(26005)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Rkh1H4Wau7FYQXoZXymwdT/3qgDE7BlCy51u2LIDpHE45b+/VAfJxhK56kRMmuoeKQvIup/xKjjir2jedE0n7wVp+Z+KeJoqofY8XwAWFCIe7ibW9XiQf0GeyiKPd0ZFjGzOq/0sKec1041S5YmjU3jQH2Rowgu541TeWR2I86UgNwuOPc5AGshmXn9ZvHpV2Aump6Y/i4G8GO9KRq23kfsCEMHFsjmjuM4stUcowsPD36uSM7Nro5/HANLXhL8F+JIeKhadWk/3Zr9krxiJdZJRczZsG3YY+YLmGwopmnK8WdOhQ6HNek1f/5rBbh7Q958DAxahJ0ezElHaJW+RJKb2a2rP9VuEv87eOtsr9zJVL/UibZGTopwE8FM09LjRVcw6mHfKJrsAqO2n1CM9LNhTKzk02Qf88vQuqqCWoBo8MJLgDiXfQuOPo5cTG0rQhrhrWNMTeodQLgJJ3BIGu2xWEJATWeiJePsASnxrsC3/zu0odybeOi0t+hsxDJgb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2704990d-153b-47de-2885-08d81bda504d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 03:12:53.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UL6sV9THIBPhEYY2E47RUUp3jQvNHw7YzuDzHniRlwrxR0i1t6u42ukzln7CvRoVTywjnfgS+qgRSbrENo+Ciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Monday, June 29, 2020 10:19 AM
> To: trix@redhat.com
> Cc: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wu, Hao <hao.wu@intel.com>;
> matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
>=20
> I think maybe we don't have to select them all. It is now possible for
> FPGA DFL boards to work without FME or AFU, providing limited
> functionality. It is possible designers trim the bitstream for their
> purpose, and also need a smaller driver set.
>=20

Yes, we hope that this dfl-pci could be a common module shared by
different cards. Some device doesn't have FME, e.g. some VF device
with AFU only, some device has FME, but no PR support, and in the
future, it's possible to add new modules, or something replacing AFU
or FME, so we don't have to select all here.

> I think we may add "default FPGA_DFL" for FPGA_DFL_FME,
> FPGA_DFL_FME_MGR and others to make life easier.

It's hard to say it's easier for everybody, e.g. I am a user of N3000, but
I have to unselect the PR modules, as they are default Yes as proposed?
Maybe it's better to let user select what they want, unless we find
something really common needed under DFL framework.

Hao
