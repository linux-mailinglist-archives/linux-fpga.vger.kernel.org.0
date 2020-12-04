Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854A82CE821
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Dec 2020 07:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLDGXr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Dec 2020 01:23:47 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:54721
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgLDGXr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Dec 2020 01:23:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsQKeMehFAKW3+NzdI3XhfRkaYn+JsPbfq7cIGy8T27vVlGb3tt0Zk/i8Tqg0xlnfHUL2EQLU8Hotsauhg4p93vc618hdi9G9QL90dLfdfNYB91GThKc1xB7QrfEvZmuSYxrHF9SgjbQViDks8WgLnpi2Z0gmvxc3XJgu3Zc9Uz+/3mL2BCm2+/GydevtoYRW7GYZ/zfyAUu+cUuYDsWbnGBdStRuEw28JFVhS2/A0EagE2ljQJkaGabsMhvL+Jc3fHI21kXlOokrJNdg50kTUsZQAk9LlUGfxbSR1W5+trq1Vfr7StVBw4+XmdRHyBGkrO0QAxhVzJO82R8RRIJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTW3A1gVCxdG9m979m5PIkOpVHIoCn48E4CmTOVgQHM=;
 b=O3KFTxXDLbXOWyBqZs3yvsJ8Jopqv9X7dnervr6M+AuXNUKGQYj72tkaJTk2r0LENgIYip14ZkKRWCVXVTGMUYwsVeJkuqzSU1c8Ie2WmFF5k1DaNLXPiM7/EzIxAtSy+tpxl8Gx0ZMG0oPvvXY5Cs/O4fDT9fkP0fgcMUtlDvTm8z+NeaBPTBYOy9P8JhQq4408hOyiPB/UPqclhUxjL5vZla/AR9+fdyoOQNe8cu/ZR3mjB6328WCTfSjlU/ngPAyEL7iIVSDzXhFCTI3+MnO2+Ba1HkkmfNTlqg0mMrb12tMUZBNR7mxt6FGCn2BNps8iTCj15EGCPPkNaJidRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTW3A1gVCxdG9m979m5PIkOpVHIoCn48E4CmTOVgQHM=;
 b=aSXjm+M/q/5PynRvadUmn8zHO2Af9A+Or/xyzBQoP1jK55Y2xX0Ky0N68rQMzrAkC/R7s78z3D4kRD0ygS50hNdGnJ5zkQ+aeB7js6a+cTGmMLqtxK5vfyVNncYBQzfVtYr5p2R8BkImfHPTVVCCf3702vbZCEfRr6CUqkJqucc=
Received: from BY5PR02MB6260.namprd02.prod.outlook.com (2603:10b6:a03:1b0::29)
 by BYAPR02MB4598.namprd02.prod.outlook.com (2603:10b6:a03:5f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 06:22:03 +0000
Received: from BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5]) by BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5%7]) with mapi id 15.20.3611.025; Fri, 4 Dec 2020
 06:22:02 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH Xilinx Alveo 7/8] fpga: xrt: Alveo management physical
 function driver
Thread-Topic: [PATCH Xilinx Alveo 7/8] fpga: xrt: Alveo management physical
 function driver
Thread-Index: AQHWxeMGvuknKCOBBk+nxkwUVZHdLKniu7sAgAMKIQCAAATmsA==
Date:   Fri, 4 Dec 2020 06:22:02 +0000
Message-ID: <BY5PR02MB6260FF818B3A736056073108BBF10@BY5PR02MB6260.namprd02.prod.outlook.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-8-sonals@xilinx.com> <X8as1jA0RnJONzFb@archbook>
 <BY5PR02MB60683E3470179E6AD10FEE26B9F20@BY5PR02MB6068.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB60683E3470179E6AD10FEE26B9F20@BY5PR02MB6068.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [98.207.149.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e40dbda-14c6-4be6-e211-08d8981cea3c
x-ms-traffictypediagnostic: BYAPR02MB4598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB45989184CE5AAB125D7CDDC9BBF10@BYAPR02MB4598.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjKQApGaiPJETeLTk8vrut1DJhiZFaYb2sGRHKHYxCb1qo2tZ/2jmuFm3/cCc1v/KKvJfyvs9tiSnk8IjArMCElmbZsrc1Yp1Qvd6QxjZSaBA80pQ+bKk/p3c6x6T9DCx5ZBGd7oyG99aU0mjETuUTVy17z1bpU4KWDwxwDiVao8ZG1Va0xZyuNzTDchc6RRq6CK3p7hFIrxBQFSLUF7zyde0kyAqw31yRTXX6UQ6SDRxsD68n9/rqnUQwHZ4gPnNImBPMBZ9GZSQuUCHIOf9u4cUwLE9V8SULf3G3NHcdKjGIxEZ4U/I72CP5L7s059OyGPWyU3xAAimHUuUOS2GISqKxfmOtAS2TkTOF973Q+Z8wC+CaUEut/bOGU472WA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6260.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(66446008)(64756008)(4326008)(66476007)(54906003)(66556008)(8936002)(2906002)(76116006)(66946007)(71200400001)(316002)(186003)(52536014)(26005)(33656002)(5660300002)(30864003)(86362001)(55016002)(83380400001)(9686003)(6506007)(53546011)(6916009)(8676002)(478600001)(7696005)(21314003)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6DdJqxLo1N1rs9ddphVFOmWGsVAVLGV68J8oioX0ub0rColexxlwNBtU7wjn?=
 =?us-ascii?Q?uvHlq/iH6hSBSgz/7BUlX9pVH7tN6OG4AwzfLnsHMAWtTU6ya2O76aSWD9Bd?=
 =?us-ascii?Q?491RL3yfdsfOkZhotrNNFdfl0j05s5j19+mLff1Yy609aswQOB9L+2x/2mU6?=
 =?us-ascii?Q?DsMsfLU+5/GraAv/HWTJZ3c52RU7O4cmaMMXXIFC6fTionWjn0WT2xWcYetx?=
 =?us-ascii?Q?ULYlFHqPN7BzyOxAYTIjDVTSbWgUbJK6+ufL8hhG/O7rqFzuN8q+9n9zqlXn?=
 =?us-ascii?Q?yPaXaumG0lI47tRO+c1gFYoCxTDihJ+NgsBiq3cc7+s8g9iAgPpdjmTOGgdC?=
 =?us-ascii?Q?LllgPeaxCkNUNhquSmy1GDwFh/RoPqXZc9IBtnfmHqJYDk/T+NifJOkRaUTd?=
 =?us-ascii?Q?huFtSurQV8xtYJeceV9kECRBBY+UY/FSwFR8EgNuMXPiDYd9JxdwPvF3qonU?=
 =?us-ascii?Q?6e+1HQz+dYZRQE3nctwXVhg59MlIHK/T/0ZHJOsvbnm1h7zo6ad/AhWNhX2I?=
 =?us-ascii?Q?2hS3Ej9pUcBIWxee7LseFF4hcdvtdkynIWqAQbCuHb2s6w00fykJWv1UtGHS?=
 =?us-ascii?Q?8WtnaGcutzMO3G4ZgxbgRonhks8dYx1KOeZtokL/rQDrx9os0AxWeN4h+Ijw?=
 =?us-ascii?Q?ydUZMc5wL/wqqrHgpZCdDd68LtkMKluneDdgDjDR1hQKISJYdNkoQpkP/PDX?=
 =?us-ascii?Q?x8N0o7iy3qcN/z7dhStyFlVs2DsKbQHxTbZ1ERaZk5EatILk3hpjNed7zXRy?=
 =?us-ascii?Q?Dy/Y8rVjKql8AIYVA79J6iPVB9qMPa6rGRLjUooScsys1z8in7xl42LhXkIs?=
 =?us-ascii?Q?FiN4KPwXjSnEHaNtP7EZykzUcF/a1GyF+CfF35+rOH5OkzmY2g39JHsqI0e+?=
 =?us-ascii?Q?cfB0nAjGFaNBEht8jkVA90/7nDel9iR/ManHxRQVjRiTLPn09o53uxbW6eED?=
 =?us-ascii?Q?rauh+rk5ps94ON12DYzWuaFqzpUCsnnhUtTnG4O0egg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6260.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e40dbda-14c6-4be6-e211-08d8981cea3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 06:22:02.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+sXb2Ydyx43ohXSw7SxD7HAQVmgAJi0d0RHU7co/w59PgWbg27Qz5VOq7Nwp9BI7NL1RU2GmtKf0t1OaYnBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4598
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Moritz,

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Tuesday, December 1, 2020 12:52
> To: Sonal Santan <sonals@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Max Zhen
<maxz@xilinx.com>; Lizhi Hou <lizhih@xilinx.com>; Michal
> Simek <michals@xilinx.com>; Stefano Stabellini <stefanos@xilinx.com>;
devicetree@vger.kernel.org
> Subject: Re: [PATCH Xilinx Alveo 7/8] fpga: xrt: Alveo management physica=
l
function driver
>
>
> Hi Sonal,
>
> On Sat, Nov 28, 2020 at 04:00:39PM -0800, Sonal Santan wrote:
> > From: Sonal Santan <sonal.santan@xilinx.com>
> >
> > Add management physical function driver core. The driver attaches
> > to management physical function of Alveo devices. It instantiates
> > the root driver and one or more partition drivers which in turn
> > instantiate platform drivers. The instantiation of partition and
> > platform drivers is completely data driven. The driver integrates
> > with FPGA manager and provides xclbin download service.
> >
> > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > ---
> >  drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c     | 194 ++++
> >  drivers/fpga/alveo/mgmt/xmgmt-fmgr.h         |  29 +
> >  drivers/fpga/alveo/mgmt/xmgmt-main-impl.h    |  36 +
> >  drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c | 930
+++++++++++++++++++
> >  drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c     | 190 ++++
> >  drivers/fpga/alveo/mgmt/xmgmt-main.c         | 843 +++++++++++++++++
> >  drivers/fpga/alveo/mgmt/xmgmt-root.c         | 375 ++++++++
> >  7 files changed, 2597 insertions(+)
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-root.c
> >
> > diff --git a/drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
b/drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
> > new file mode 100644
> > index 000000000000..d451b5a2c291
> > --- /dev/null
> > +++ b/drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
> > @@ -0,0 +1,194 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx Alveo Management Function Driver
> > + *
> > + * Copyright (C) 2019-2020 Xilinx, Inc.
> > + * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
> > + *
> > + * Authors: Sonal.Santan@xilinx.com
> > + */
> > +
> > +#include <linux/cred.h>
> > +#include <linux/efi.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/module.h>
> > +#include <linux/vmalloc.h>
> > +
> > +#include "xrt-subdev.h"
> > +#include "xmgmt-fmgr.h"
> > +#include "xrt-axigate.h"
> > +#include "xmgmt-main-impl.h"
> > +
> > +/*
> > + * Container to capture and cache full xclbin as it is passed in block=
s by
FPGA
> > + * Manager. Driver needs access to full xclbin to walk through xclbin
sections.
> > + * FPGA Manager's .write() backend sends incremental blocks without an=
y
> > + * knowledge of xclbin format forcing us to collect the blocks and sti=
tch
them
> > + * together here.
> > + */
> > +
> > +struct xfpga_klass {
> Nit: xfpga_priv or xfpga_drvdata?
> > +     const struct platform_device *pdev;
> > +     struct axlf         *blob;
> > +     char                 name[64];
> Nit: 64 could be a named constant ?
> > +     size_t               count;
> > +     size_t               total_count;
> > +     struct mutex         axlf_lock;
> > +     int                  reader_ref;
> > +     enum fpga_mgr_states state;
> > +     enum xfpga_sec_level sec_level;
> This appears unused, do you want to add this with the code that uses it?

This hook is for validating signature of FPGA image. Will look into adding =
it
into the next version of the patch.

> > +};
>
> Maybe add some kerneldoc markup?

Will do in the next version

> > +
> > +struct key *xfpga_keys;
> Appears unused, can you introduce this together with the code using it?
> > +
> > +static int xmgmt_pr_write_init(struct fpga_manager *mgr,
> > +     struct fpga_image_info *info, const char *buf, size_t count)
> > +{
> > +     struct xfpga_klass *obj =3D mgr->priv;
> > +     const struct axlf *bin =3D (const struct axlf *)buf;
> Nit: Reverse x-mas tree please.
>
> xxxxxx
> xxxx
> xxx
> x

Will update in the next version

> > +
> > +     if (count < sizeof(struct axlf)) {
> > +             obj->state =3D FPGA_MGR_STATE_WRITE_INIT_ERR;
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (count > bin->m_header.m_length) {
> > +             obj->state =3D FPGA_MGR_STATE_WRITE_INIT_ERR;
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Free up the previous blob */
> > +     vfree(obj->blob);
> > +     obj->blob =3D vmalloc(bin->m_header.m_length);
> > +     if (!obj->blob) {
> > +             obj->state =3D FPGA_MGR_STATE_WRITE_INIT_ERR;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     xrt_info(obj->pdev, "Begin download of xclbin %pUb of length %lld=
 B",
> > +             &bin->m_header.uuid, bin->m_header.m_length);
> We already have framework level prints for that (admittedly somewhat
> less verbose). Please remove.

Will update in the next version
> > +
> > +     obj->count =3D 0;
> > +     obj->total_count =3D bin->m_header.m_length;
> > +     obj->state =3D FPGA_MGR_STATE_WRITE_INIT;
> Does the framework state tracking not work for you?
> > +     return 0;
> > +}
> > +
> > +static int xmgmt_pr_write(struct fpga_manager *mgr,
> > +     const char *buf, size_t count)
> > +{
> > +     struct xfpga_klass *obj =3D mgr->priv;
> > +     char *curr =3D (char *)obj->blob;
> > +
> > +     if ((obj->state !=3D FPGA_MGR_STATE_WRITE_INIT) &&
> > +             (obj->state !=3D FPGA_MGR_STATE_WRITE)) {
> > +             obj->state =3D FPGA_MGR_STATE_WRITE_ERR;
> > +             return -EINVAL;
> > +     }
> > +
> > +     curr +=3D obj->count;
> > +     obj->count +=3D count;
> > +
> > +     /*
> > +      * The xclbin buffer should not be longer than advertised in the =
header
> > +      */
> > +     if (obj->total_count < obj->count) {
> > +             obj->state =3D FPGA_MGR_STATE_WRITE_ERR;
> > +             return -EINVAL;
> > +     }
> > +
> > +     xrt_info(obj->pdev, "Copying block of %zu B of xclbin", count);
> Please drop those.
> > +     memcpy(curr, buf, count);
>
> I'm confused. Why are we just copying things around here. What picks
> this up afterwards?

The current implementation caches the full FPGA image in a local buffer so
we can walk various segments of the xclbin container to identify bitstreams=
,
clock scaling metadata, etc. Full image is also needed for signature verifi=
cation.
Does the framework guarantee one .write call in case fpga_image_info is
created with complete buffer? That will remove the need to cache the buffer=
.

> > +     obj->state =3D FPGA_MGR_STATE_WRITE;
> > +     return 0;
> > +}
> > +
> > +
> > +static int xmgmt_pr_write_complete(struct fpga_manager *mgr,
> > +                                struct fpga_image_info *info)
> > +{
> > +     int result =3D 0;
> > +     struct xfpga_klass *obj =3D mgr->priv;
> > +
> > +     if (obj->state !=3D FPGA_MGR_STATE_WRITE) {
> > +             obj->state =3D FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Check if we got the complete xclbin */
> > +     if (obj->blob->m_header.m_length !=3D obj->count) {
> > +             obj->state =3D FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
> > +             return -EINVAL;
> > +     }
> > +
> > +     result =3D xmgmt_ulp_download((void *)obj->pdev, obj->blob);
> > +
> > +     obj->state =3D result ? FPGA_MGR_STATE_WRITE_COMPLETE_ERR :
> > +             FPGA_MGR_STATE_WRITE_COMPLETE;
> Why the separate state tracking?
> > +     xrt_info(obj->pdev, "Finish downloading of xclbin %pUb: %d",
> > +             &obj->blob->m_header.uuid, result);
> > +     vfree(obj->blob);
> > +     obj->blob =3D NULL;
> > +     obj->count =3D 0;
> > +     return result;
> > +}
> > +
> > +static enum fpga_mgr_states xmgmt_pr_state(struct fpga_manager
*mgr)
> > +{
> > +     struct xfpga_klass *obj =3D mgr->priv;
> > +
> > +     return obj->state;
> > +}
> > +
> > +static const struct fpga_manager_ops xmgmt_pr_ops =3D {
> > +     .initial_header_size =3D sizeof(struct axlf),
> > +     .write_init =3D xmgmt_pr_write_init,
> > +     .write =3D xmgmt_pr_write,
> > +     .write_complete =3D xmgmt_pr_write_complete,
> > +     .state =3D xmgmt_pr_state,
> > +};
> > +
> > +
> > +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev)
> > +{
> > +     struct fpga_manager *fmgr;
> > +     int ret =3D 0;
> > +     struct xfpga_klass *obj =3D vzalloc(sizeof(struct xfpga_klass));
> > +
> > +     xrt_info(pdev, "probing...");
> Drop this, please.
> > +     if (!obj)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     snprintf(obj->name, sizeof(obj->name), "Xilinx Alveo FPGA Manager=
");
> > +     obj->state =3D FPGA_MGR_STATE_UNKNOWN;
> > +     obj->pdev =3D pdev;
> > +     fmgr =3D fpga_mgr_create(&pdev->dev,
> > +                            obj->name,
> > +                            &xmgmt_pr_ops,
> > +                            obj);
> I think (eyeballed) this fits on two lines?
> > +     if (!fmgr)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     obj->sec_level =3D XFPGA_SEC_NONE;
> Seems unused so far, please drop until it's used.
> > +     ret =3D fpga_mgr_register(fmgr);
> > +     if (ret) {
> > +             fpga_mgr_free(fmgr);
> > +             kfree(obj);
> > +             return ERR_PTR(ret);
> > +     }
> > +     mutex_init(&obj->axlf_lock);
> > +     return fmgr;
> Since this patchset will wait at least till next cycle, you might want
> to look into the devm_* functions for registering and creating FPGA
> Managers.

Will address this in next revision of the patch.

>
> > +}
> > +
> > +int xmgmt_fmgr_remove(struct fpga_manager *fmgr)
> > +{
> > +     struct xfpga_klass *obj =3D fmgr->priv;
> > +
> > +     mutex_destroy(&obj->axlf_lock);
> > +     obj->state =3D FPGA_MGR_STATE_UNKNOWN;
> > +     fpga_mgr_unregister(fmgr);
> > +     vfree(obj->blob);
> > +     vfree(obj);
> > +     return 0;
> > +}
> > diff --git a/drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
b/drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
> > new file mode 100644
> > index 000000000000..2beba649609f
> > --- /dev/null
> > +++ b/drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Xilinx Alveo Management Function Driver
> > + *
> > + * Copyright (C) 2019-2020 Xilinx, Inc.
> > + * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
> > + *
> > + * Authors: Sonal.Santan@xilinx.com
> > + */
> > +
> > +#ifndef      _XMGMT_FMGR_H_
> > +#define      _XMGMT_FMGR_H_
> > +
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/mutex.h>
> > +
> > +#include <linux/xrt/xclbin.h>
> > +
> > +enum xfpga_sec_level {
> > +     XFPGA_SEC_NONE =3D 0,
> > +     XFPGA_SEC_DEDICATE,
> > +     XFPGA_SEC_SYSTEM,
> > +     XFPGA_SEC_MAX =3D XFPGA_SEC_SYSTEM,
> > +};
> > +
> > +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev);
> > +int xmgmt_fmgr_remove(struct fpga_manager *fmgr);
> > +
> > +#endif
> > diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
b/drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
> > new file mode 100644
> > index 000000000000..c89024cb8d46
> > --- /dev/null
> > +++ b/drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
> > + *   Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#ifndef      _XMGMT_MAIN_IMPL_H_
> > +#define      _XMGMT_MAIN_IMPL_H_
> > +
> > +#include "xrt-subdev.h"
> > +#include "xmgmt-main.h"
> > +
> > +extern struct platform_driver xmgmt_main_driver;
> > +extern struct xrt_subdev_endpoints xrt_mgmt_main_endpoints[];
> > +
> > +extern int xmgmt_ulp_download(struct platform_device *pdev, const void
*xclbin);
> > +extern int bitstream_axlf_mailbox(struct platform_device *pdev,
> > +     const void *xclbin);
> > +extern int xmgmt_hot_reset(struct platform_device *pdev);
> > +
> > +/* Getting dtb for specified partition. Caller should vfree returned d=
tb .*/
> > +extern char *xmgmt_get_dtb(struct platform_device *pdev,
> > +     enum provider_kind kind);
> > +extern char *xmgmt_get_vbnv(struct platform_device *pdev);
> > +extern int xmgmt_get_provider_uuid(struct platform_device *pdev,
> > +     enum provider_kind kind, uuid_t *uuid);
> > +
> > +extern void *xmgmt_pdev2mailbox(struct platform_device *pdev);
> > +extern void *xmgmt_mailbox_probe(struct platform_device *pdev);
> > +extern void xmgmt_mailbox_remove(void *handle);
> > +extern void xmgmt_peer_notify_state(void *handle, bool online);
> > +
> > +#endif       /* _XMGMT_MAIN_IMPL_H_ */
> > diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
b/drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
> > new file mode 100644
> > index 000000000000..b3d82fc3618b
> > --- /dev/null
> > +++ b/drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
> > @@ -0,0 +1,930 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx Alveo FPGA MGMT PF entry point driver
> > + *
> > + * Copyright (C) 2020 Xilinx, Inc.
> > + *
> > + * Peer communication via mailbox
> > + *
> > + * Authors:
> > + *      Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#include <linux/crc32c.h>
> > +#include <linux/xrt/mailbox_proto.h>
> > +#include "xmgmt-main-impl.h"
> > +#include "xrt-mailbox.h"
> > +#include "xrt-cmc.h"
> > +#include "xrt-metadata.h"
> > +#include "xrt-xclbin.h"
> > +#include "xrt-clock.h"
> > +#include "xrt-calib.h"
> > +#include "xrt-icap.h"
> > +
> > +struct xmgmt_mailbox {
> > +     struct platform_device *pdev;
> > +     struct platform_device *mailbox;
> > +     struct mutex lock;
> > +     void *evt_hdl;
> > +     char *test_msg;
> > +     bool peer_in_same_domain;
> > +};
> > +
> > +#define      XMGMT_MAILBOX_PRT_REQ(xmbx, send, request, sw_ch)
do {    \
> > +     const char *dir =3D (send) ? ">>>>>" : "<<<<<";                  =
 \
> > +                                                                     \
> > +     if ((request)->req =3D=3D XCL_MAILBOX_REQ_PEER_DATA) {           =
   \
> > +             struct xcl_mailbox_peer_data *p =3D                      =
 \
> > +                     (struct xcl_mailbox_peer_data *)(request)->data;\
> > +                                                                     \
> > +             xrt_info((xmbx)->pdev, "%s(%s) %s%s",                   \
> > +                     mailbox_req2name((request)->req),               \
> > +                     mailbox_group_kind2name(p->kind),               \
> > +                     dir, mailbox_chan2name(sw_ch));                 \
> > +     } else {                                                        \
> > +             xrt_info((xmbx)->pdev, "%s %s%s",                       \
> > +                     mailbox_req2name((request)->req),               \
> > +                     dir, mailbox_chan2name(sw_ch));                 \
> > +     }                                                               \
> > +} while (0)
> > +#define      XMGMT_MAILBOX_PRT_REQ_SEND(xmbx, req, sw_ch)
\
> > +     XMGMT_MAILBOX_PRT_REQ(xmbx, true, req, sw_ch)
> > +#define      XMGMT_MAILBOX_PRT_REQ_RECV(xmbx, req, sw_ch)
\
> > +     XMGMT_MAILBOX_PRT_REQ(xmbx, false, req, sw_ch)
> > +#define      XMGMT_MAILBOX_PRT_RESP(xmbx, resp)                       =
       \
> > +     xrt_info((xmbx)->pdev, "respond %ld bytes >>>>>%s",             \
> > +     (resp)->xmip_data_size, mailbox_chan2name((resp)->xmip_sw_ch))
> > +
> > +static inline struct xmgmt_mailbox *pdev2mbx(struct platform_device
*pdev)
> > +{
> > +     return (struct xmgmt_mailbox *)xmgmt_pdev2mailbox(pdev);
> > +}
> > +
> > +static void xmgmt_mailbox_post(struct xmgmt_mailbox *xmbx,
> > +     u64 msgid, bool sw_ch, void *buf, size_t len)
> > +{
> > +     int rc;
> > +     struct xrt_mailbox_ioctl_post post =3D {
> > +             .xmip_req_id =3D msgid,
> > +             .xmip_sw_ch =3D sw_ch,
> > +             .xmip_data =3D buf,
> > +             .xmip_data_size =3D len
> > +     };
> > +
> > +     BUG_ON(!mutex_is_locked(&xmbx->lock));
> > +
> > +     if (!xmbx->mailbox) {
> > +             xrt_err(xmbx->pdev, "mailbox not available");
> > +             return;
> > +     }
> > +
> > +     if (msgid =3D=3D 0) {
> > +             XMGMT_MAILBOX_PRT_REQ_SEND(xmbx,
> > +                     (struct xcl_mailbox_req *)buf, sw_ch);
> > +     } else {
> > +             XMGMT_MAILBOX_PRT_RESP(xmbx, &post);
> > +     }
> > +
> > +     rc =3D xrt_subdev_ioctl(xmbx->mailbox, XRT_MAILBOX_POST, &post);
> > +     if (rc)
> > +             xrt_err(xmbx->pdev, "failed to post msg: %d", rc);
> > +}
> > +
> > +static void xmgmt_mailbox_notify(struct xmgmt_mailbox *xmbx, bool
sw_ch,
> > +     struct xcl_mailbox_req *req, size_t len)
> > +{
> > +     xmgmt_mailbox_post(xmbx, 0, sw_ch, req, len);
> > +}
> > +
> > +static void xmgmt_mailbox_respond(struct xmgmt_mailbox *xmbx,
> > +     u64 msgid, bool sw_ch, void *buf, size_t len)
> > +{
> > +     mutex_lock(&xmbx->lock);
> > +     xmgmt_mailbox_post(xmbx, msgid, sw_ch, buf, len);
> > +     mutex_unlock(&xmbx->lock);
> > +}
> > +
> > +static void xmgmt_mailbox_resp_test_msg(struct xmgmt_mailbox *xmbx,
> > +     u64 msgid, bool sw_ch)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     char *msg;
> > +
> > +     mutex_lock(&xmbx->lock);
> > +
> > +     if (xmbx->test_msg =3D=3D NULL) {
> > +             mutex_unlock(&xmbx->lock);
> > +             xrt_err(pdev, "test msg is not set, drop request");
> > +             return;
> > +     }
> > +     msg =3D xmbx->test_msg;
> > +     xmbx->test_msg =3D NULL;
> > +
> > +     mutex_unlock(&xmbx->lock);
> > +
> > +     xmgmt_mailbox_respond(xmbx, msgid, sw_ch, msg, strlen(msg) + 1);
> > +     vfree(msg);
> > +}
> > +
> > +static int xmgmt_mailbox_dtb_add_prop(struct platform_device *pdev,
> > +     char *dst_dtb, const char *ep_name, const char *regmap_name,
> > +     const char *prop, const void *val, int size)
> > +{
> > +     int rc =3D xrt_md_set_prop(DEV(pdev), dst_dtb, ep_name,
regmap_name,
> > +             prop, val, size);
> > +
> > +     if (rc) {
> > +             xrt_err(pdev, "failed to set %s@(%s, %s): %d",
> > +                     ep_name, regmap_name, prop, rc);
> > +     }
> > +     return rc;
> > +}
> > +
> > +static int xmgmt_mailbox_dtb_add_vbnv(struct platform_device *pdev,
char *dtb)
> > +{
> > +     int rc =3D 0;
> > +     char *vbnv =3D xmgmt_get_vbnv(pdev);
> > +
> > +     if (vbnv =3D=3D NULL) {
> > +             xrt_err(pdev, "failed to get VBNV");
> > +             return -ENOENT;
> > +     }
> > +     rc =3D xmgmt_mailbox_dtb_add_prop(pdev, dtb, NULL, NULL,
> > +             PROP_VBNV, vbnv, strlen(vbnv) + 1);
> > +     kfree(vbnv);
> > +     return rc;
> > +}
> > +
> > +static int xmgmt_mailbox_dtb_copy_logic_uuid(struct platform_device
*pdev,
> > +     const char *src_dtb, char *dst_dtb)
> > +{
> > +     const void *val;
> > +     int sz;
> > +     int rc =3D xrt_md_get_prop(DEV(pdev), src_dtb, NULL, NULL,
> > +             PROP_LOGIC_UUID, &val, &sz);
> > +
> > +     if (rc) {
> > +             xrt_err(pdev, "failed to get %s: %d", PROP_LOGIC_UUID, rc=
);
> > +             return rc;
> > +     }
> > +     return xmgmt_mailbox_dtb_add_prop(pdev, dst_dtb, NULL, NULL,
> > +             PROP_LOGIC_UUID, val, sz);
> > +}
> > +
> > +static int xmgmt_mailbox_dtb_add_vrom(struct platform_device *pdev,
> > +     const char *src_dtb, char *dst_dtb)
> > +{
> > +     /* For compatibility for legacy xrt driver. */
> > +     enum FeatureBitMask {
> > +             UNIFIED_PLATFORM                =3D 0x0000000000000001
> > +             , XARE_ENBLD                    =3D 0x0000000000000002
> > +             , BOARD_MGMT_ENBLD              =3D 0x0000000000000004
> > +             , MB_SCHEDULER                  =3D 0x0000000000000008
> > +             , PROM_MASK                     =3D 0x0000000000000070
> > +             , DEBUG_MASK                    =3D 0x000000000000FF00
> > +             , PEER_TO_PEER                  =3D 0x0000000000010000
> > +             , FBM_UUID                      =3D 0x0000000000020000
> > +             , HBM                           =3D 0x0000000000040000
> > +             , CDMA                          =3D 0x0000000000080000
> > +             , QDMA                          =3D 0x0000000000100000
> > +             , RUNTIME_CLK_SCALE             =3D 0x0000000000200000
> > +             , PASSTHROUGH_VIRTUALIZATION    =3D 0x0000000000400000
> > +     };
> > +     struct FeatureRomHeader {
> > +             unsigned char EntryPointString[4];
> > +             uint8_t MajorVersion;
> > +             uint8_t MinorVersion;
> > +             uint32_t VivadoBuildID;
> > +             uint32_t IPBuildID;
> > +             uint64_t TimeSinceEpoch;
> > +             unsigned char FPGAPartName[64];
> > +             unsigned char VBNVName[64];
> > +             uint8_t DDRChannelCount;
> > +             uint8_t DDRChannelSize;
> > +             uint64_t DRBaseAddress;
> > +             uint64_t FeatureBitMap;
> > +             unsigned char uuid[16];
> > +             uint8_t HBMCount;
> > +             uint8_t HBMSize;
> > +             uint32_t CDMABaseAddress[4];
> > +     } header =3D { 0 };
> > +     char *vbnv =3D xmgmt_get_vbnv(pdev);
> > +     int rc;
> > +
> > +     *(u32 *)header.EntryPointString =3D 0x786e6c78;
> > +
> > +     if (vbnv)
> > +             strncpy(header.VBNVName, vbnv, sizeof(header.VBNVName) - =
1);
> > +     kfree(vbnv);
> > +
> > +     header.FeatureBitMap =3D UNIFIED_PLATFORM;
> > +     rc =3D xrt_md_get_prop(DEV(pdev), src_dtb,
> > +             NODE_CMC_FW_MEM, NULL, PROP_IO_OFFSET, NULL, NULL);
> > +     if (rc =3D=3D 0)
> > +             header.FeatureBitMap |=3D BOARD_MGMT_ENBLD;
> > +     rc =3D xrt_md_get_prop(DEV(pdev), src_dtb,
> > +             NODE_ERT_FW_MEM, NULL, PROP_IO_OFFSET, NULL, NULL);
> > +     if (rc =3D=3D 0)
> > +             header.FeatureBitMap |=3D MB_SCHEDULER;
> > +
> > +     return xmgmt_mailbox_dtb_add_prop(pdev, dst_dtb, NULL, NULL,
> > +             PROP_VROM, &header, sizeof(header));
> > +}
> > +
> > +static u32 xmgmt_mailbox_dtb_user_pf(struct platform_device *pdev,
> > +     const char *dtb, const char *epname, const char *regmap)
> > +{
> > +     const u32 *pfnump;
> > +     int rc =3D xrt_md_get_prop(DEV(pdev), dtb, epname, regmap,
> > +             PROP_PF_NUM, (const void **)&pfnump, NULL);
> > +
> > +     if (rc)
> > +             return -1;
> > +     return be32_to_cpu(*pfnump);
> > +}
> > +
> > +static int xmgmt_mailbox_dtb_copy_user_endpoints(struct
platform_device *pdev,
> > +     const char *src, char *dst)
> > +{
> > +     int rc =3D 0;
> > +     char *epname =3D NULL, *regmap =3D NULL;
> > +     u32 pfnum =3D xmgmt_mailbox_dtb_user_pf(pdev, src,
> > +             NODE_MAILBOX_USER, NULL);
> > +     const u32 level =3D cpu_to_be32(1);
> > +     struct device *dev =3D DEV(pdev);
> > +
> > +     if (pfnum =3D=3D (u32)-1) {
> > +             xrt_err(pdev, "failed to get user pf num");
> > +             rc =3D -EINVAL;
> > +     }
> > +
> > +     for (xrt_md_get_next_endpoint(dev, src, NULL, NULL, &epname,
&regmap);
> > +             rc =3D=3D 0 && epname !=3D NULL;
> > +             xrt_md_get_next_endpoint(dev, src, epname, regmap,
> > +             &epname, &regmap)) {
> > +             if (pfnum !=3D
> > +                     xmgmt_mailbox_dtb_user_pf(pdev, src, epname, regm=
ap))
> > +                     continue;
> > +             rc =3D xrt_md_copy_endpoint(dev, dst, src, epname, regmap=
, NULL);
> > +             if (rc) {
> > +                     xrt_err(pdev, "failed to copy (%s, %s): %d",
> > +                             epname, regmap, rc);
> > +             } else {
> > +                     rc =3D xrt_md_set_prop(dev, dst, epname, regmap,
> > +                             PROP_PARTITION_LEVEL, &level, sizeof(leve=
l));
> > +                     if (rc) {
> > +                             xrt_err(pdev,
> > +                                     "can't set level for (%s, %s): %d=
",
> > +                                     epname, regmap, rc);
> > +                     }
> > +             }
> > +     }
> > +     return rc;
> > +}
> > +
> > +static char *xmgmt_mailbox_user_dtb(struct platform_device *pdev)
> > +{
> > +     /* TODO: add support for PLP. */
> > +     const char *src =3D NULL;
> > +     char *dst =3D NULL;
> > +     struct device *dev =3D DEV(pdev);
> > +     int rc =3D xrt_md_create(dev, &dst);
> > +
> > +     if (rc || dst =3D=3D NULL)
> > +             return NULL;
> > +
> > +     rc =3D xmgmt_mailbox_dtb_add_vbnv(pdev, dst);
> > +     if (rc)
> > +             goto fail;
> > +
> > +     src =3D xmgmt_get_dtb(pdev, XMGMT_BLP);
> > +     if (src =3D=3D NULL) {
> > +             xrt_err(pdev, "failed to get BLP dtb");
> > +             goto fail;
> > +     }
> > +
> > +     rc =3D xmgmt_mailbox_dtb_copy_logic_uuid(pdev, src, dst);
> > +     if (rc)
> > +             goto fail;
> > +
> > +     rc =3D xmgmt_mailbox_dtb_add_vrom(pdev, src, dst);
> > +     if (rc)
> > +             goto fail;
> > +
> > +     rc =3D xrt_md_copy_endpoint(dev, dst, src, NODE_PARTITION_INFO,
> > +             NULL, NODE_PARTITION_INFO_BLP);
> > +     if (rc)
> > +             goto fail;
> > +
> > +     rc =3D xrt_md_copy_endpoint(dev, dst, src, NODE_INTERFACES, NULL,
NULL);
> > +     if (rc)
> > +             goto fail;
> > +
> > +     rc =3D xmgmt_mailbox_dtb_copy_user_endpoints(pdev, src, dst);
> > +     if (rc)
> > +             goto fail;
> > +
> > +     xrt_md_pack(dev, dst);
> > +     vfree(src);
> > +     return dst;
> > +
> > +fail:
> > +     vfree(src);
> > +     vfree(dst);
> > +     return NULL;
> > +}
> > +
> > +static void xmgmt_mailbox_resp_subdev(struct xmgmt_mailbox *xmbx,
> > +     u64 msgid, bool sw_ch, u64 offset, u64 size)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     char *dtb =3D xmgmt_mailbox_user_dtb(pdev);
> > +     long dtbsz;
> > +     struct xcl_subdev *hdr;
> > +     u64 totalsz;
> > +
> > +     if (dtb =3D=3D NULL)
> > +             return;
> > +
> > +     dtbsz =3D xrt_md_size(DEV(pdev), dtb);
> > +     totalsz =3D dtbsz + sizeof(*hdr) - sizeof(hdr->data);
> > +     if (offset !=3D 0 || totalsz > size) {
> > +             /* Only support fetching dtb in one shot. */
> > +             vfree(dtb);
> > +             xrt_err(pdev, "need %lldB, user buffer size is %lldB, dro=
pped",
> > +                     totalsz, size);
> > +             return;
> > +     }
> > +
> > +     hdr =3D vzalloc(totalsz);
> > +     if (hdr =3D=3D NULL) {
> > +             vfree(dtb);
> > +             return;
> > +     }
> > +
> > +     hdr->ver =3D 1;
> > +     hdr->size =3D dtbsz;
> > +     hdr->rtncode =3D XRT_MSG_SUBDEV_RTN_COMPLETE;
> > +     (void) memcpy(hdr->data, dtb, dtbsz);
> > +
> > +     xmgmt_mailbox_respond(xmbx, msgid, sw_ch, hdr, totalsz);
> > +
> > +     vfree(dtb);
> > +     vfree(hdr);
> > +}
> > +
> > +static void xmgmt_mailbox_resp_sensor(struct xmgmt_mailbox *xmbx,
> > +     u64 msgid, bool sw_ch, u64 offset, u64 size)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     struct xcl_sensor sensors =3D { 0 };
> > +     struct platform_device *cmcpdev =3D xrt_subdev_get_leaf_by_id(pde=
v,
> > +             XRT_SUBDEV_CMC, PLATFORM_DEVID_NONE);
> > +     int rc;
> > +
> > +     if (cmcpdev) {
> > +             rc =3D xrt_subdev_ioctl(cmcpdev, XRT_CMC_READ_SENSORS,
&sensors);
> > +             (void) xrt_subdev_put_leaf(pdev, cmcpdev);
> > +             if (rc)
> > +                     xrt_err(pdev, "can't read sensors: %d", rc);
> > +     }
> > +
> > +     xmgmt_mailbox_respond(xmbx, msgid, sw_ch, &sensors,
> > +             min((u64)sizeof(sensors), size));
> > +}
> > +
> > +static int xmgmt_mailbox_get_freq(struct xmgmt_mailbox *xmbx,
> > +     enum CLOCK_TYPE type, u64 *freq, u64 *freq_cnter)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     const char *clkname =3D
> > +             clock_type2epname(type) ? clock_type2epname(type) :
"UNKNOWN";
> > +     struct platform_device *clkpdev =3D
> > +             xrt_subdev_get_leaf_by_epname(pdev, clkname);
> > +     int rc;
> > +     struct xrt_clock_ioctl_get getfreq =3D { 0 };
> > +
> > +     if (clkpdev =3D=3D NULL) {
> > +             xrt_info(pdev, "%s clock is not available", clkname);
> > +             return -ENOENT;
> > +     }
> > +
> > +     rc =3D xrt_subdev_ioctl(clkpdev, XRT_CLOCK_GET, &getfreq);
> > +     (void) xrt_subdev_put_leaf(pdev, clkpdev);
> > +     if (rc) {
> > +             xrt_err(pdev, "can't get %s clock frequency: %d", clkname=
, rc);
> > +             return rc;
> > +     }
> > +
> > +     if (freq)
> > +             *freq =3D getfreq.freq;
> > +     if (freq_cnter)
> > +             *freq_cnter =3D getfreq.freq_cnter;
> > +     return 0;
> > +}
> > +
> > +static int xmgmt_mailbox_get_icap_idcode(struct xmgmt_mailbox *xmbx,
u64 *id)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     struct platform_device *icappdev =3D xrt_subdev_get_leaf_by_id(pd=
ev,
> > +             XRT_SUBDEV_ICAP, PLATFORM_DEVID_NONE);
> > +     int rc;
> > +
> > +     if (icappdev =3D=3D NULL) {
> > +             xrt_err(pdev, "can't find icap");
> > +             return -ENOENT;
> > +     }
> > +
> > +     rc =3D xrt_subdev_ioctl(icappdev, XRT_ICAP_IDCODE, id);
> > +     (void) xrt_subdev_put_leaf(pdev, icappdev);
> > +     if (rc)
> > +             xrt_err(pdev, "can't get icap idcode: %d", rc);
> > +     return rc;
> > +}
> > +
> > +static int xmgmt_mailbox_get_mig_calib(struct xmgmt_mailbox *xmbx,
u64 *calib)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     struct platform_device *calibpdev =3D xrt_subdev_get_leaf_by_id(p=
dev,
> > +             XRT_SUBDEV_CALIB, PLATFORM_DEVID_NONE);
> > +     int rc;
> > +     enum xrt_calib_results res;
> > +
> > +     if (calibpdev =3D=3D NULL) {
> > +             xrt_err(pdev, "can't find mig calibration subdev");
> > +             return -ENOENT;
> > +     }
> > +
> > +     rc =3D xrt_subdev_ioctl(calibpdev, XRT_CALIB_RESULT, &res);
> > +     (void) xrt_subdev_put_leaf(pdev, calibpdev);
> > +     if (rc) {
> > +             xrt_err(pdev, "can't get mig calibration result: %d", rc)=
;
> > +     } else {
> > +             if (res =3D=3D XRT_CALIB_SUCCEEDED)
> > +                     *calib =3D 1;
> > +             else
> > +                     *calib =3D 0;
> > +     }
> > +     return rc;
> > +}
> > +
> > +static void xmgmt_mailbox_resp_icap(struct xmgmt_mailbox *xmbx,
> > +     u64 msgid, bool sw_ch, u64 offset, u64 size)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     struct xcl_pr_region icap =3D { 0 };
> > +
> > +     (void) xmgmt_mailbox_get_freq(xmbx,
> > +             CT_DATA, &icap.freq_data, &icap.freq_cntr_data);
> > +     (void) xmgmt_mailbox_get_freq(xmbx,
> > +             CT_KERNEL, &icap.freq_kernel, &icap.freq_cntr_kernel);
> > +     (void) xmgmt_mailbox_get_freq(xmbx,
> > +             CT_SYSTEM, &icap.freq_system, &icap.freq_cntr_system);
> > +     (void) xmgmt_mailbox_get_icap_idcode(xmbx, &icap.idcode);
> > +     (void) xmgmt_mailbox_get_mig_calib(xmbx, &icap.mig_calib);
> > +     BUG_ON(sizeof(icap.uuid) !=3D sizeof(uuid_t));
> > +     (void) xmgmt_get_provider_uuid(pdev, XMGMT_ULP, (uuid_t
*)&icap.uuid);
> > +
> > +     xmgmt_mailbox_respond(xmbx, msgid, sw_ch, &icap,
> > +             min((u64)sizeof(icap), size));
> > +}
> > +
> > +static void xmgmt_mailbox_resp_bdinfo(struct xmgmt_mailbox *xmbx,
> > +     u64 msgid, bool sw_ch, u64 offset, u64 size)
> > +{
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     struct xcl_board_info *info =3D vzalloc(sizeof(*info));
> > +     struct platform_device *cmcpdev;
> > +     int rc;
> > +
> > +     if (info =3D=3D NULL)
> > +             return;
> > +
> > +     cmcpdev =3D xrt_subdev_get_leaf_by_id(pdev,
> > +             XRT_SUBDEV_CMC, PLATFORM_DEVID_NONE);
> > +     if (cmcpdev) {
> > +             rc =3D xrt_subdev_ioctl(cmcpdev, XRT_CMC_READ_BOARD_INFO,
info);
> > +             (void) xrt_subdev_put_leaf(pdev, cmcpdev);
> > +             if (rc)
> > +                     xrt_err(pdev, "can't read board info: %d", rc);
> > +     }
> > +
> > +     xmgmt_mailbox_respond(xmbx, msgid, sw_ch, info,
> > +             min((u64)sizeof(*info), size));
> > +
> > +     vfree(info);
> > +}
> > +
> > +static void xmgmt_mailbox_simple_respond(struct xmgmt_mailbox
*xmbx,
> > +     u64 msgid, bool sw_ch, int rc)
> > +{
> > +     xmgmt_mailbox_respond(xmbx, msgid, sw_ch, &rc, sizeof(rc));
> > +}
> > +
> > +static void xmgmt_mailbox_resp_peer_data(struct xmgmt_mailbox
*xmbx,
> > +     struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
> > +{
> > +     struct xcl_mailbox_peer_data *pdata =3D
> > +             (struct xcl_mailbox_peer_data *)req->data;
> > +
> > +     if (len < (sizeof(*req) + sizeof(*pdata) - 1)) {
> > +             xrt_err(xmbx->pdev, "received corrupted %s, dropped",
> > +                     mailbox_req2name(req->req));
> > +             return;
> > +     }
> > +
> > +     switch (pdata->kind) {
> > +     case XCL_SENSOR:
> > +             xmgmt_mailbox_resp_sensor(xmbx, msgid, sw_ch,
> > +                     pdata->offset, pdata->size);
> > +             break;
> > +     case XCL_ICAP:
> > +             xmgmt_mailbox_resp_icap(xmbx, msgid, sw_ch,
> > +                     pdata->offset, pdata->size);
> > +             break;
> > +     case XCL_BDINFO:
> > +             xmgmt_mailbox_resp_bdinfo(xmbx, msgid, sw_ch,
> > +                     pdata->offset, pdata->size);
> > +             break;
> > +     case XCL_SUBDEV:
> > +             xmgmt_mailbox_resp_subdev(xmbx, msgid, sw_ch,
> > +                     pdata->offset, pdata->size);
> > +             break;
> > +     case XCL_MIG_ECC:
> > +     case XCL_FIREWALL:
> > +     case XCL_DNA: /* TODO **/
> > +             xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, 0);
> > +             break;
> > +     default:
> > +             xrt_err(xmbx->pdev, "%s(%s) request not handled",
> > +                     mailbox_req2name(req->req),
> > +                     mailbox_group_kind2name(pdata->kind));
> > +             break;
> > +     }
> > +}
> > +
> > +static bool xmgmt_mailbox_is_same_domain(struct xmgmt_mailbox
*xmbx,
> > +     struct xcl_mailbox_conn *mb_conn)
> > +{
> > +     uint32_t crc_chk;
> > +     phys_addr_t paddr;
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +
> > +     paddr =3D virt_to_phys((void *)mb_conn->kaddr);
> > +     if (paddr !=3D (phys_addr_t)mb_conn->paddr) {
> > +             xrt_info(pdev, "paddrs differ, user 0x%llx, mgmt 0x%llx",
> > +                     mb_conn->paddr, paddr);
> > +             return false;
> > +     }
> > +
> > +     crc_chk =3D crc32c_le(~0, (void *)mb_conn->kaddr, PAGE_SIZE);
> > +     if (crc_chk !=3D mb_conn->crc32) {
> > +             xrt_info(pdev, "CRCs differ, user 0x%x, mgmt 0x%x",
> > +                     mb_conn->crc32, crc_chk);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static void xmgmt_mailbox_resp_user_probe(struct xmgmt_mailbox
*xmbx,
> > +     struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
> > +{
> > +     struct xcl_mailbox_conn_resp *resp =3D vzalloc(sizeof(*resp));
> > +     struct xcl_mailbox_conn *conn =3D (struct xcl_mailbox_conn *)req-=
>data;
> > +
> > +     if (resp =3D=3D NULL)
> > +             return;
> > +
> > +     if (len < (sizeof(*req) + sizeof(*conn) - 1)) {
> > +             xrt_err(xmbx->pdev, "received corrupted %s, dropped",
> > +                     mailbox_req2name(req->req));
> > +             vfree(resp);
> > +             return;
> > +     }
> > +
> > +     resp->conn_flags |=3D XCL_MB_PEER_READY;
> > +     if (xmgmt_mailbox_is_same_domain(xmbx, conn)) {
> > +             xmbx->peer_in_same_domain =3D true;
> > +             resp->conn_flags |=3D XCL_MB_PEER_SAME_DOMAIN;
> > +     }
> > +
> > +     xmgmt_mailbox_respond(xmbx, msgid, sw_ch, resp, sizeof(*resp));
> > +     vfree(resp);
> > +}
> > +
> > +static void xmgmt_mailbox_resp_hot_reset(struct xmgmt_mailbox *xmbx,
> > +     struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
> > +{
> > +     int ret;
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +
> > +     xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, 0);
> > +
> > +     ret =3D xmgmt_hot_reset(pdev);
> > +     if (ret)
> > +             xrt_err(pdev, "failed to hot reset: %d", ret);
> > +     else
> > +             xmgmt_peer_notify_state(xmbx, true);
> > +}
> > +
> > +static void xmgmt_mailbox_resp_load_xclbin(struct xmgmt_mailbox
*xmbx,
> > +     struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
> > +{
> > +     struct xcl_mailbox_bitstream_kaddr *kaddr =3D
> > +             (struct xcl_mailbox_bitstream_kaddr *)req->data;
> > +     void *xclbin =3D (void *)(uintptr_t)kaddr->addr;
> > +     int ret =3D bitstream_axlf_mailbox(xmbx->pdev, xclbin);
> > +
> > +     xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, ret);
> > +}
> > +
> > +static void xmgmt_mailbox_listener(void *arg, void *data, size_t len,
> > +     u64 msgid, int err, bool sw_ch)
> > +{
> > +     struct xmgmt_mailbox *xmbx =3D (struct xmgmt_mailbox *)arg;
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     struct xcl_mailbox_req *req =3D (struct xcl_mailbox_req *)data;
> > +
> > +     if (err) {
> > +             xrt_err(pdev, "failed to receive request: %d", err);
> > +             return;
> > +     }
> > +     if (len < sizeof(*req)) {
> > +             xrt_err(pdev, "received corrupted request");
> > +             return;
> > +     }
> > +
> > +     XMGMT_MAILBOX_PRT_REQ_RECV(xmbx, req, sw_ch);
> > +     switch (req->req) {
> > +     case XCL_MAILBOX_REQ_TEST_READ:
> > +             xmgmt_mailbox_resp_test_msg(xmbx, msgid, sw_ch);
> > +             break;
> > +     case XCL_MAILBOX_REQ_PEER_DATA:
> > +             xmgmt_mailbox_resp_peer_data(xmbx, req, len, msgid, sw_ch=
);
> > +             break;
> > +     case XCL_MAILBOX_REQ_READ_P2P_BAR_ADDR: /* TODO */
> > +             xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, -
ENOTSUPP);
> > +             break;
> > +     case XCL_MAILBOX_REQ_USER_PROBE:
> > +             xmgmt_mailbox_resp_user_probe(xmbx, req, len, msgid, sw_c=
h);
> > +             break;
> > +     case XCL_MAILBOX_REQ_HOT_RESET:
> > +             xmgmt_mailbox_resp_hot_reset(xmbx, req, len, msgid, sw_ch=
);
> > +             break;
> > +     case XCL_MAILBOX_REQ_LOAD_XCLBIN_KADDR:
> > +             if (xmbx->peer_in_same_domain) {
> > +                     xmgmt_mailbox_resp_load_xclbin(xmbx,
> > +                             req, len, msgid, sw_ch);
> > +             } else {
> > +                     xrt_err(pdev, "%s not handled, not in same domain=
",
> > +                             mailbox_req2name(req->req));
> > +             }
> > +             break;
> > +     default:
> > +             xrt_err(pdev, "%s(%d) request not handled",
> > +                     mailbox_req2name(req->req), req->req);
> > +             break;
> > +     }
> > +}
> > +
> > +static void xmgmt_mailbox_reg_listener(struct xmgmt_mailbox *xmbx)
> > +{
> > +     struct xrt_mailbox_ioctl_listen listen =3D {
> > +             xmgmt_mailbox_listener, xmbx };
> > +
> > +     BUG_ON(!mutex_is_locked(&xmbx->lock));
> > +     if (!xmbx->mailbox)
> > +             return;
> > +     (void) xrt_subdev_ioctl(xmbx->mailbox, XRT_MAILBOX_LISTEN,
&listen);
> > +}
> > +
> > +static void xmgmt_mailbox_unreg_listener(struct xmgmt_mailbox *xmbx)
> > +{
> > +     struct xrt_mailbox_ioctl_listen listen =3D { 0 };
> > +
> > +     BUG_ON(!mutex_is_locked(&xmbx->lock));
> > +     BUG_ON(!xmbx->mailbox);
> > +     (void) xrt_subdev_ioctl(xmbx->mailbox, XRT_MAILBOX_LISTEN,
&listen);
> > +}
> > +
> > +static bool xmgmt_mailbox_leaf_match(enum xrt_subdev_id id,
> > +     struct platform_device *pdev, void *arg)
> > +{
> > +     return (id =3D=3D XRT_SUBDEV_MAILBOX);
> > +}
> > +
> > +static int xmgmt_mailbox_event_cb(struct platform_device *pdev,
> > +     enum xrt_events evt, void *arg)
> > +{
> > +     struct xmgmt_mailbox *xmbx =3D pdev2mbx(pdev);
> > +     struct xrt_event_arg_subdev *esd =3D (struct xrt_event_arg_subdev
*)arg;
> > +
> > +     switch (evt) {
> > +     case XRT_EVENT_POST_CREATION:
> > +             BUG_ON(esd->xevt_subdev_id !=3D XRT_SUBDEV_MAILBOX);
> > +             BUG_ON(xmbx->mailbox);
> > +             mutex_lock(&xmbx->lock);
> > +             xmbx->mailbox =3D xrt_subdev_get_leaf_by_id(pdev,
> > +                     XRT_SUBDEV_MAILBOX, PLATFORM_DEVID_NONE);
> > +             xmgmt_mailbox_reg_listener(xmbx);
> > +             mutex_unlock(&xmbx->lock);
> > +             break;
> > +     case XRT_EVENT_PRE_REMOVAL:
> > +             BUG_ON(esd->xevt_subdev_id !=3D XRT_SUBDEV_MAILBOX);
> > +             BUG_ON(!xmbx->mailbox);
> > +             mutex_lock(&xmbx->lock);
> > +             xmgmt_mailbox_unreg_listener(xmbx);
> > +             (void) xrt_subdev_put_leaf(pdev, xmbx->mailbox);
> > +             xmbx->mailbox =3D NULL;
> > +             mutex_unlock(&xmbx->lock);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return XRT_EVENT_CB_CONTINUE;
> > +}
> > +
> > +static ssize_t xmgmt_mailbox_user_dtb_show(struct file *filp,
> > +     struct kobject *kobj, struct bin_attribute *attr,
> > +     char *buf, loff_t off, size_t count)
> > +{
> > +     struct device *dev =3D kobj_to_dev(kobj);
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +     char *blob =3D NULL;
> > +     long  size;
> > +     ssize_t ret =3D 0;
> > +
> > +     blob =3D xmgmt_mailbox_user_dtb(pdev);
> > +     if (!blob) {
> > +             ret =3D -ENOENT;
> > +             goto failed;
> > +     }
> > +
> > +     size =3D xrt_md_size(dev, blob);
> > +     if (size <=3D 0) {
> > +             ret =3D -EINVAL;
> > +             goto failed;
> > +     }
> > +
> > +     if (off >=3D size)
> > +             goto failed;
> > +     if (off + count > size)
> > +             count =3D size - off;
> > +     memcpy(buf, blob + off, count);
> > +
> > +     ret =3D count;
> > +failed:
> > +     vfree(blob);
> > +     return ret;
> > +}
> > +
> > +static struct bin_attribute meta_data_attr =3D {
> > +     .attr =3D {
> > +             .name =3D "metadata_for_user",
> > +             .mode =3D 0400
> > +     },
> > +     .read =3D xmgmt_mailbox_user_dtb_show,
> > +     .size =3D 0
> > +};
> > +
> > +static struct bin_attribute  *xmgmt_mailbox_bin_attrs[] =3D {
> > +     &meta_data_attr,
> > +     NULL,
> > +};
> > +
> > +int xmgmt_mailbox_get_test_msg(struct xmgmt_mailbox *xmbx, bool
sw_ch,
> > +     char *buf, size_t *len)
> > +{
> > +     int rc;
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +     struct xcl_mailbox_req req =3D { 0, XCL_MAILBOX_REQ_TEST_READ, };
> > +     struct xrt_mailbox_ioctl_request leaf_req =3D {
> > +             .xmir_sw_ch =3D sw_ch,
> > +             .xmir_resp_ttl =3D 1,
> > +             .xmir_req =3D &req,
> > +             .xmir_req_size =3D sizeof(req),
> > +             .xmir_resp =3D buf,
> > +             .xmir_resp_size =3D *len
> > +     };
> > +
> > +     mutex_lock(&xmbx->lock);
> > +     if (xmbx->mailbox) {
> > +             XMGMT_MAILBOX_PRT_REQ_SEND(xmbx, &req,
leaf_req.xmir_sw_ch);
> > +             /*
> > +              * mgmt should never send request to peer. it should send
> > +              * either notification or response. here is the only exce=
ption
> > +              * for debugging purpose.
> > +              */
> > +             rc =3D xrt_subdev_ioctl(xmbx->mailbox,
> > +                     XRT_MAILBOX_REQUEST, &leaf_req);
> > +     } else {
> > +             rc =3D -ENODEV;
> > +             xrt_err(pdev, "mailbox not available");
> > +     }
> > +     mutex_unlock(&xmbx->lock);
> > +
> > +     if (rc =3D=3D 0)
> > +             *len =3D leaf_req.xmir_resp_size;
> > +     return rc;
> > +}
> > +
> > +int xmgmt_mailbox_set_test_msg(struct xmgmt_mailbox *xmbx,
> > +     char *buf, size_t len)
> > +{
> > +     mutex_lock(&xmbx->lock);
> > +
> > +     if (xmbx->test_msg)
> > +             vfree(xmbx->test_msg);
> > +     xmbx->test_msg =3D vmalloc(len);
> > +     if (xmbx->test_msg =3D=3D NULL) {
> > +             mutex_unlock(&xmbx->lock);
> > +             return -ENOMEM;
> > +     }
> > +     (void) memcpy(xmbx->test_msg, buf, len);
> > +
> > +     mutex_unlock(&xmbx->lock);
> > +     return 0;
> > +}
> > +
> > +static ssize_t peer_msg_show(struct device *dev,
> > +     struct device_attribute *attr, char *buf)
> > +{
> > +     size_t len =3D 4096;
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +     struct xmgmt_mailbox *xmbx =3D pdev2mbx(pdev);
> > +     int ret =3D xmgmt_mailbox_get_test_msg(xmbx, false, buf, &len);
> > +
> > +     return ret =3D=3D 0 ? len : ret;
> > +}
> > +static ssize_t peer_msg_store(struct device *dev,
> > +     struct device_attribute *da, const char *buf, size_t count)
> > +{
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +     struct xmgmt_mailbox *xmbx =3D pdev2mbx(pdev);
> > +     int ret =3D xmgmt_mailbox_set_test_msg(xmbx, (char *)buf, count);
> > +
> > +     return ret =3D=3D 0 ? count : ret;
> > +}
> > +/* Message test i/f. */
> > +static DEVICE_ATTR_RW(peer_msg);
> > +
> > +static struct attribute *xmgmt_mailbox_attrs[] =3D {
> > +     &dev_attr_peer_msg.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group xmgmt_mailbox_attrgroup =3D {
> > +     .bin_attrs =3D xmgmt_mailbox_bin_attrs,
> > +     .attrs =3D xmgmt_mailbox_attrs,
> > +};
> > +
> > +void *xmgmt_mailbox_probe(struct platform_device *pdev)
> > +{
> > +     struct xmgmt_mailbox *xmbx =3D
> > +             devm_kzalloc(DEV(pdev), sizeof(*xmbx), GFP_KERNEL);
> > +
> > +     if (!xmbx)
> > +             return NULL;
> > +     xmbx->pdev =3D pdev;
> > +     mutex_init(&xmbx->lock);
> > +
> > +     xmbx->evt_hdl =3D xrt_subdev_add_event_cb(pdev,
> > +             xmgmt_mailbox_leaf_match, NULL, xmgmt_mailbox_event_cb);
> > +     (void) sysfs_create_group(&DEV(pdev)->kobj,
&xmgmt_mailbox_attrgroup);
> > +     return xmbx;
> > +}
> > +
> > +void xmgmt_mailbox_remove(void *handle)
> > +{
> > +     struct xmgmt_mailbox *xmbx =3D (struct xmgmt_mailbox *)handle;
> > +     struct platform_device *pdev =3D xmbx->pdev;
> > +
> > +     (void) sysfs_remove_group(&DEV(pdev)->kobj,
&xmgmt_mailbox_attrgroup);
> > +     if (xmbx->evt_hdl)
> > +             (void) xrt_subdev_remove_event_cb(pdev, xmbx->evt_hdl);
> > +     if (xmbx->mailbox)
> > +             (void) xrt_subdev_put_leaf(pdev, xmbx->mailbox);
> > +     if (xmbx->test_msg)
> > +             vfree(xmbx->test_msg);
> > +}
> > +
> > +void xmgmt_peer_notify_state(void *handle, bool online)
> > +{
> > +     struct xmgmt_mailbox *xmbx =3D (struct xmgmt_mailbox *)handle;
> > +     struct xcl_mailbox_peer_state *st;
> > +     struct xcl_mailbox_req *req;
> > +     size_t reqlen =3D sizeof(*req) + sizeof(*st) - 1;
> > +
> > +     req =3D vzalloc(reqlen);
> > +     if (req =3D=3D NULL)
> > +             return;
> > +
> > +     req->req =3D XCL_MAILBOX_REQ_MGMT_STATE;
> > +     st =3D (struct xcl_mailbox_peer_state *)req->data;
> > +     st->state_flags =3D online ? XCL_MB_STATE_ONLINE :
XCL_MB_STATE_OFFLINE;
> > +     mutex_lock(&xmbx->lock);
> > +     xmgmt_mailbox_notify(xmbx, false, req, reqlen);
> > +     mutex_unlock(&xmbx->lock);
> > +}
> > diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
b/drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
> > new file mode 100644
> > index 000000000000..042d86fcef41
> > --- /dev/null
> > +++ b/drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
> > @@ -0,0 +1,190 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx Alveo FPGA MGMT PF entry point driver
> > + *
> > + * Copyright (C) 2020 Xilinx, Inc.
> > + *
> > + * xclbin download
> > + *
> > + * Authors:
> > + *      Lizhi Hou <lizhi.hou@xilinx.com>
> > + */
> > +
> > +#include <linux/firmware.h>
> > +#include <linux/uaccess.h>
> > +#include "xrt-xclbin.h"
> > +#include "xrt-metadata.h"
> > +#include "xrt-subdev.h"
> > +#include "xrt-gpio.h"
> > +#include "xmgmt-main.h"
> > +#include "xrt-icap.h"
> > +#include "xrt-axigate.h"
> > +
> > +static int xmgmt_download_bitstream(struct platform_device  *pdev,
> > +     const void *xclbin)
> > +{
> > +     struct platform_device *icap_leaf =3D NULL;
> > +     struct XHwIcap_Bit_Header bit_header =3D { 0 };
> Please fix the style error in struct name ...
> > +     struct xrt_icap_ioctl_wr arg;
> > +     char *bitstream =3D NULL;
> > +     int ret;
> > +
> > +     ret =3D xrt_xclbin_get_section(xclbin, BITSTREAM, (void **)&bitst=
ream,
> > +             NULL);
> > +     if (ret || !bitstream) {
> > +             xrt_err(pdev, "bitstream not found");
> > +             return -ENOENT;
> > +     }
> > +     ret =3D xrt_xclbin_parse_header(bitstream,
> > +             DMA_HWICAP_BITFILE_BUFFER_SIZE, &bit_header);
> > +     if (ret) {
> > +             ret =3D -EINVAL;
> > +             xrt_err(pdev, "invalid bitstream header");
> > +             goto done;
> > +     }
> > +     icap_leaf =3D xrt_subdev_get_leaf_by_id(pdev, XRT_SUBDEV_ICAP,
> > +             PLATFORM_DEVID_NONE);
> > +     if (!icap_leaf) {
> > +             ret =3D -ENODEV;
> > +             xrt_err(pdev, "icap does not exist");
> > +             goto done;
> > +     }
> > +     arg.xiiw_bit_data =3D bitstream + bit_header.HeaderLength;
> > +     arg.xiiw_data_len =3D bit_header.BitstreamLength;
> > +     ret =3D xrt_subdev_ioctl(icap_leaf, XRT_ICAP_WRITE, &arg);
> > +     if (ret)
> > +             xrt_err(pdev, "write bitstream failed, ret =3D %d", ret);
> > +
> > +done:
> > +     if (icap_leaf)
> > +             xrt_subdev_put_leaf(pdev, icap_leaf);
> > +     vfree(bitstream);
> > +
> > +     return ret;
> > +}
> > +
> > +static bool match_shell(enum xrt_subdev_id id,
> > +     struct platform_device *pdev, void *arg)
> > +{
> > +     struct xrt_subdev_platdata *pdata =3D DEV_PDATA(pdev);
> > +     const char *ulp_gate;
> > +     int ret;
> > +
> > +     if (!pdata || xrt_md_size(&pdev->dev, pdata->xsp_dtb) <=3D 0)
> > +             return false;
> > +
> > +     ret =3D xrt_md_get_epname_pointer(&pdev->dev, pdata->xsp_dtb,
> > +             NODE_GATE_ULP, NULL, &ulp_gate);
> > +     if (ret)
> > +             return false;
> > +
> > +     ret =3D xrt_md_check_uuids(&pdev->dev, pdata->xsp_dtb, arg);
> > +     if (ret)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +static bool match_ulp(enum xrt_subdev_id id,
> > +     struct platform_device *pdev, void *arg)
> > +{
> > +     struct xrt_subdev_platdata *pdata =3D DEV_PDATA(pdev);
> > +     const char *ulp_gate;
> > +     int ret;
> > +
> > +     if (!pdata || xrt_md_size(&pdev->dev, pdata->xsp_dtb) <=3D 0)
> > +             return false;
> > +
> > +     ret =3D xrt_md_check_uuids(&pdev->dev, pdata->xsp_dtb, arg);
> > +     if (ret)
> > +             return false;
> > +
> > +     ret =3D xrt_md_get_epname_pointer(&pdev->dev, pdata->xsp_dtb,
> > +             NODE_GATE_ULP, NULL, &ulp_gate);
> > +     if (!ret)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +int xmgmt_ulp_download(struct platform_device  *pdev, const void
*xclbin)
> > +{
> > +     struct platform_device *axigate_leaf;
> > +     char *dtb =3D NULL;
> > +     int ret =3D 0, part_inst;
> > +
> > +     ret =3D xrt_xclbin_get_metadata(DEV(pdev), xclbin, &dtb);
> > +     if (ret) {
> > +             xrt_err(pdev, "can not get partition metadata, ret %d", r=
et);
> > +             goto failed;
> > +     }
> > +
> > +     part_inst =3D xrt_subdev_lookup_partition(pdev, match_shell, dtb)=
;
> > +     if (part_inst < 0) {
> > +             xrt_err(pdev, "not found matching plp.");
> > +             ret =3D -ENODEV;
> > +             goto failed;
> > +     }
> > +
> > +     /*
> > +      * Find ulp partition with interface uuid from incoming xclbin, w=
hich
> > +      * is verified before with matching plp partition.
> > +      */
> > +     part_inst =3D xrt_subdev_lookup_partition(pdev, match_ulp, dtb);
> > +     if (part_inst >=3D 0) {
> > +             ret =3D xrt_subdev_destroy_partition(pdev, part_inst);
> > +             if (ret) {
> > +                     xrt_err(pdev, "failed to destroy existing ulp, %d=
",
> > +                             ret);
> > +                     goto failed;
> > +             }
> > +     }
> > +
> > +     axigate_leaf =3D xrt_subdev_get_leaf_by_epname(pdev,
NODE_GATE_ULP);
> > +
> > +     /* gate may not be exist for 0rp */
> > +     if (axigate_leaf) {
> > +             ret =3D xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREEZE=
,
> > +                     NULL);
> > +             if (ret) {
> > +                     xrt_err(pdev, "can not freeze gate %s, %d",
> > +                             NODE_GATE_ULP, ret);
> > +                     xrt_subdev_put_leaf(pdev, axigate_leaf);
> > +                     goto failed;
> > +             }
> > +     }
> > +     ret =3D xmgmt_download_bitstream(pdev, xclbin);
> > +     if (axigate_leaf) {
> > +             xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREE, NULL);
> > +
> > +             /* Do we really need this extra toggling gate before sett=
ing
> > +              * clocks?
> > +              * xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREEZE, NUL=
L);
> > +              * xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREE, NULL)=
;
> > +              */
> > +
> > +             xrt_subdev_put_leaf(pdev, axigate_leaf);
> > +     }
> > +     if (ret) {
> > +             xrt_err(pdev, "bitstream download failed, ret %d", ret);
> > +             goto failed;
> > +     }
> > +     ret =3D xrt_subdev_create_partition(pdev, dtb);
> > +     if (ret < 0) {
> > +             xrt_err(pdev, "failed creating partition, ret %d", ret);
> > +             goto failed;
> > +     }
> > +
> > +     ret =3D xrt_subdev_wait_for_partition_bringup(pdev);
> > +     if (ret)
> > +             xrt_err(pdev, "partiton bringup failed, ret %d", ret);
> > +
> > +     /*
> > +      * TODO: needs to check individual subdevs to see if there
> > +      * is any error, such as clock setting, memory bank calibration.
> > +      */
> > +
> > +failed:
> > +     vfree(dtb);
> > +     return ret;
> > +}
> > diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main.c
b/drivers/fpga/alveo/mgmt/xmgmt-main.c
> > new file mode 100644
> > index 000000000000..23e68e3a4ae1
> > --- /dev/null
> > +++ b/drivers/fpga/alveo/mgmt/xmgmt-main.c
> > @@ -0,0 +1,843 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx Alveo FPGA MGMT PF entry point driver
> > + *
> > + * Copyright (C) 2020 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *   Sonal Santan <sonals@xilinx.com>
> > + */
> > +
> > +#include <linux/firmware.h>
> > +#include <linux/uaccess.h>
> > +#include "xrt-xclbin.h"
> > +#include "xrt-metadata.h"
> > +#include "xrt-flash.h"
> > +#include "xrt-subdev.h"
> > +#include <linux/xrt/flash_xrt_data.h>
> > +#include <linux/xrt/xmgmt-ioctl.h>
> > +#include "xrt-gpio.h"
> > +#include "xmgmt-main.h"
> > +#include "xmgmt-fmgr.h"
> > +#include "xrt-icap.h"
> > +#include "xrt-axigate.h"
> > +#include "xmgmt-main-impl.h"
> > +
> > +#define      XMGMT_MAIN "xmgmt_main"
> > +
> > +struct xmgmt_main {
> > +     struct platform_device *pdev;
> > +     void *evt_hdl;
> > +     char *firmware_blp;
> > +     char *firmware_plp;
> > +     char *firmware_ulp;
> > +     bool flash_ready;
> > +     bool gpio_ready;
> > +     struct fpga_manager *fmgr;
> > +     void *mailbox_hdl;
> > +     struct mutex busy_mutex;
> > +
> > +     uuid_t *blp_intf_uuids;
> > +     u32 blp_intf_uuid_num;
> > +};
> > +
> > +char *xmgmt_get_vbnv(struct platform_device *pdev)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +     const char *vbnv;
> > +     char *ret;
> > +     int i;
> > +
> > +     if (xmm->firmware_plp) {
> > +             vbnv =3D ((struct axlf *)xmm->firmware_plp)->
> > +                     m_header.m_platformVBNV;
> > +     } else if (xmm->firmware_blp) {
> > +             vbnv =3D ((struct axlf *)xmm->firmware_blp)->
> > +                     m_header.m_platformVBNV;
> > +     } else {
> > +             return NULL;
> > +     }
> > +
> > +     ret =3D kstrdup(vbnv, GFP_KERNEL);
> > +     for (i =3D 0; i < strlen(ret); i++) {
> > +             if (ret[i] =3D=3D ':' || ret[i] =3D=3D '.')
> > +                     ret[i] =3D '_';
> > +     }
> > +     return ret;
> > +}
> > +
> > +static bool xmgmt_main_leaf_match(enum xrt_subdev_id id,
> > +     struct platform_device *pdev, void *arg)
> > +{
> > +     if (id =3D=3D XRT_SUBDEV_GPIO)
> > +             return xrt_subdev_has_epname(pdev, arg);
> > +     else if (id =3D=3D XRT_SUBDEV_QSPI)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static int get_dev_uuid(struct platform_device *pdev, char *uuidstr, s=
ize_t
len)
> > +{
> > +     char uuid[16];
> > +     struct platform_device *gpio_leaf;
> > +     struct xrt_gpio_ioctl_rw gpio_arg =3D { 0 };
> > +     int err, i, count;
> > +
> > +     gpio_leaf =3D xrt_subdev_get_leaf_by_epname(pdev, NODE_BLP_ROM);
> > +     if (!gpio_leaf) {
> > +             xrt_err(pdev, "can not get %s", NODE_BLP_ROM);
> > +             return -EINVAL;
> > +     }
> > +
> > +     gpio_arg.xgir_id =3D XRT_GPIO_ROM_UUID;
> > +     gpio_arg.xgir_buf =3D uuid;
> > +     gpio_arg.xgir_len =3D sizeof(uuid);
> > +     gpio_arg.xgir_offset =3D 0;
> > +     err =3D xrt_subdev_ioctl(gpio_leaf, XRT_GPIO_READ, &gpio_arg);
> > +     xrt_subdev_put_leaf(pdev, gpio_leaf);
> > +     if (err) {
> > +             xrt_err(pdev, "can not get uuid: %d", err);
> > +             return err;
> > +     }
> > +
> > +     for (count =3D 0, i =3D sizeof(uuid) - sizeof(u32);
> > +             i >=3D 0 && len > count; i -=3D sizeof(u32)) {
> > +             count +=3D snprintf(uuidstr + count, len - count,
> > +                     "%08x", *(u32 *)&uuid[i]);
> > +     }
> > +     return 0;
> > +}
> > +
> > +int xmgmt_hot_reset(struct platform_device *pdev)
> > +{
> > +     int ret =3D xrt_subdev_broadcast_event(pdev,
XRT_EVENT_PRE_HOT_RESET);
> > +
> > +     if (ret) {
> > +             xrt_err(pdev, "offline failed, hot reset is canceled");
> > +             return ret;
> > +     }
> > +
> > +     (void) xrt_subdev_hot_reset(pdev);
> > +     xrt_subdev_broadcast_event(pdev, XRT_EVENT_POST_HOT_RESET);
> > +     return 0;
> > +}
> > +
> > +static ssize_t reset_store(struct device *dev,
> > +     struct device_attribute *da, const char *buf, size_t count)
> > +{
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +
> > +     (void) xmgmt_hot_reset(pdev);
> > +     return count;
> > +}
> > +static DEVICE_ATTR_WO(reset);
> > +
> > +static ssize_t VBNV_show(struct device *dev,
> > +     struct device_attribute *da, char *buf)
> > +{
> > +     ssize_t ret;
> > +     char *vbnv;
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +
> > +     vbnv =3D xmgmt_get_vbnv(pdev);
> > +     ret =3D sprintf(buf, "%s\n", vbnv);
> > +     kfree(vbnv);
> > +     return ret;
> > +}
> > +static DEVICE_ATTR_RO(VBNV);
> > +
> > +static ssize_t logic_uuids_show(struct device *dev,
> > +     struct device_attribute *da, char *buf)
> > +{
> > +     ssize_t ret;
> > +     char uuid[80];
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +
> > +     /*
> > +      * Getting UUID pointed to by VSEC,
> > +      * should be the same as logic UUID of BLP.
> > +      * TODO: add PLP logic UUID
> > +      */
> > +     ret =3D get_dev_uuid(pdev, uuid, sizeof(uuid));
> > +     if (ret)
> > +             return ret;
> > +     ret =3D sprintf(buf, "%s\n", uuid);
> > +     return ret;
> > +}
> > +static DEVICE_ATTR_RO(logic_uuids);
> > +
> > +static inline void uuid2str(const uuid_t *uuid, char *uuidstr, size_t =
len)
> > +{
> > +     int i, p;
> > +     u8 *u =3D (u8 *)uuid;
> > +
> > +     BUG_ON(sizeof(uuid_t) * 2 + 1 > len);
> > +     for (p =3D 0, i =3D sizeof(uuid_t) - 1; i >=3D 0; p++, i--)
> > +             (void) snprintf(&uuidstr[p*2], 3, "%02x", u[i]);
> > +}
> > +
> > +static ssize_t interface_uuids_show(struct device *dev,
> > +     struct device_attribute *da, char *buf)
> > +{
> > +     ssize_t ret =3D 0;
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +     u32 i;
> > +
> > +     /*
> > +      * TODO: add PLP interface UUID
> > +      */
> > +     for (i =3D 0; i < xmm->blp_intf_uuid_num; i++) {
> > +             char uuidstr[80];
> > +
> > +             uuid2str(&xmm->blp_intf_uuids[i], uuidstr, sizeof(uuidstr=
));
> > +             ret +=3D sprintf(buf + ret, "%s\n", uuidstr);
> > +     }
> > +     return ret;
> > +}
> > +static DEVICE_ATTR_RO(interface_uuids);
> > +
> > +static struct attribute *xmgmt_main_attrs[] =3D {
> > +     &dev_attr_reset.attr,
> > +     &dev_attr_VBNV.attr,
> > +     &dev_attr_logic_uuids.attr,
> > +     &dev_attr_interface_uuids.attr,
> > +     NULL,
> > +};
> > +
> > +static ssize_t ulp_image_write(struct file *filp, struct kobject *kobj=
,
> > +     struct bin_attribute *attr, char *buffer, loff_t off, size_t coun=
t)
> > +{
> > +     struct xmgmt_main *xmm =3D
> > +             dev_get_drvdata(container_of(kobj, struct device, kobj));
> > +     struct axlf *xclbin;
> > +     ulong len;
> > +
> > +     if (off =3D=3D 0) {
> > +             if (count < sizeof(*xclbin)) {
> > +                     xrt_err(xmm->pdev, "count is too small %ld", coun=
t);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (xmm->firmware_ulp) {
> > +                     vfree(xmm->firmware_ulp);
> > +                     xmm->firmware_ulp =3D NULL;
> > +             }
> > +             xclbin =3D (struct axlf *)buffer;
> > +             xmm->firmware_ulp =3D vmalloc(xclbin->m_header.m_length);
> > +             if (!xmm->firmware_ulp)
> > +                     return -ENOMEM;
> > +     } else
> > +             xclbin =3D (struct axlf *)xmm->firmware_ulp;
> > +
> > +     len =3D xclbin->m_header.m_length;
> > +     if (off + count >=3D len && off < len) {
> > +             memcpy(xmm->firmware_ulp + off, buffer, len - off);
> > +             xmgmt_ulp_download(xmm->pdev, xmm->firmware_ulp);
> > +     } else if (off + count < len) {
> > +             memcpy(xmm->firmware_ulp + off, buffer, count);
> > +     }
> > +
> > +     return count;
> > +}
> > +
> > +static struct bin_attribute ulp_image_attr =3D {
> > +     .attr =3D {
> > +             .name =3D "ulp_image",
> > +             .mode =3D 0200
> > +     },
> > +     .write =3D ulp_image_write,
> > +     .size =3D 0
> > +};
> > +
> > +static struct bin_attribute *xmgmt_main_bin_attrs[] =3D {
> > +     &ulp_image_attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group xmgmt_main_attrgroup =3D {
> > +     .attrs =3D xmgmt_main_attrs,
> > +     .bin_attrs =3D xmgmt_main_bin_attrs,
> > +};
> > +
> > +static int load_firmware_from_flash(struct platform_device *pdev,
> > +     char **fw_buf, size_t *len)
> > +{
> > +     struct platform_device *flash_leaf =3D NULL;
> > +     struct flash_data_header header =3D { 0 };
> > +     const size_t magiclen =3D sizeof(header.fdh_id_begin.fdi_magic);
> > +     size_t flash_size =3D 0;
> > +     int ret =3D 0;
> > +     char *buf =3D NULL;
> > +     struct flash_data_ident id =3D { 0 };
> > +     struct xrt_flash_ioctl_read frd =3D { 0 };
> > +
> > +     xrt_info(pdev, "try loading fw from flash");
> > +
> > +     flash_leaf =3D xrt_subdev_get_leaf_by_id(pdev, XRT_SUBDEV_QSPI,
> > +             PLATFORM_DEVID_NONE);
> > +     if (flash_leaf =3D=3D NULL) {
> > +             xrt_err(pdev, "failed to hold flash leaf");
> > +             return -ENODEV;
> > +     }
> > +
> > +     (void) xrt_subdev_ioctl(flash_leaf, XRT_FLASH_GET_SIZE, &flash_si=
ze);
> > +     if (flash_size =3D=3D 0) {
> > +             xrt_err(pdev, "failed to get flash size");
> > +             ret =3D -EINVAL;
> > +             goto done;
> > +     }
> > +
> > +     frd.xfir_buf =3D (char *)&header;
> > +     frd.xfir_size =3D sizeof(header);
> > +     frd.xfir_offset =3D flash_size - sizeof(header);
> > +     ret =3D xrt_subdev_ioctl(flash_leaf, XRT_FLASH_READ, &frd);
> > +     if (ret) {
> > +             xrt_err(pdev, "failed to read header from flash: %d", ret=
);
> > +             goto done;
> > +     }
> > +
> > +     /* Pick the end ident since header is aligned in the end of flash=
. */
> > +     id =3D header.fdh_id_end;
> > +     if (strncmp(id.fdi_magic, XRT_DATA_MAGIC, magiclen)) {
> > +             char tmp[sizeof(id.fdi_magic) + 1] =3D { 0 };
> > +
> > +             memcpy(tmp, id.fdi_magic, magiclen);
> > +             xrt_info(pdev, "ignore meta data, bad magic: %s", tmp);
> > +             ret =3D -ENOENT;
> > +             goto done;
> > +     }
> > +     if (id.fdi_version !=3D 0) {
> > +             xrt_info(pdev, "flash meta data version is not supported:=
 %d",
> > +                     id.fdi_version);
> > +             ret =3D -EOPNOTSUPP;
> > +             goto done;
> > +     }
> > +
> > +     buf =3D vmalloc(header.fdh_data_len);
> > +     if (buf =3D=3D NULL) {
> > +             ret =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +
> > +     frd.xfir_buf =3D buf;
> > +     frd.xfir_size =3D header.fdh_data_len;
> > +     frd.xfir_offset =3D header.fdh_data_offset;
> > +     ret =3D xrt_subdev_ioctl(flash_leaf, XRT_FLASH_READ, &frd);
> > +     if (ret) {
> > +             xrt_err(pdev, "failed to read meta data from flash: %d", =
ret);
> > +             goto done;
> > +     } else if (flash_xrt_data_get_parity32(buf, header.fdh_data_len) =
^
> > +             header.fdh_data_parity) {
> > +             xrt_err(pdev, "meta data is corrupted");
> > +             ret =3D -EINVAL;
> > +             goto done;
> > +     }
> > +
> > +     xrt_info(pdev, "found meta data of %d bytes @0x%x",
> > +             header.fdh_data_len, header.fdh_data_offset);
> > +     *fw_buf =3D buf;
> > +     *len =3D header.fdh_data_len;
> > +
> > +done:
> > +     (void) xrt_subdev_put_leaf(pdev, flash_leaf);
> > +     return ret;
> > +}
> > +
> > +static int load_firmware_from_disk(struct platform_device *pdev, char
**fw_buf,
> > +     size_t *len)
> > +{
> > +     char uuid[80];
> > +     int err =3D 0;
> > +     char fw_name[256];
> > +     const struct firmware *fw;
> > +
> > +     err =3D get_dev_uuid(pdev, uuid, sizeof(uuid));
> > +     if (err)
> > +             return err;
> > +
> > +     (void) snprintf(fw_name,
> > +             sizeof(fw_name), "xilinx/%s/partition.xsabin", uuid);
> > +     xrt_info(pdev, "try loading fw: %s", fw_name);
> > +
> > +     err =3D request_firmware(&fw, fw_name, DEV(pdev));
> > +     if (err)
> > +             return err;
> > +
> > +     *fw_buf =3D vmalloc(fw->size);
> > +     *len =3D fw->size;
> > +     if (*fw_buf !=3D NULL)
> > +             memcpy(*fw_buf, fw->data, fw->size);
> > +     else
> > +             err =3D -ENOMEM;
> > +
> > +     release_firmware(fw);
> > +     return 0;
> > +}
> > +
> > +static const char *xmgmt_get_axlf_firmware(struct xmgmt_main *xmm,
> > +     enum provider_kind kind)
> > +{
> > +     switch (kind) {
> > +     case XMGMT_BLP:
> > +             return xmm->firmware_blp;
> > +     case XMGMT_PLP:
> > +             return xmm->firmware_plp;
> > +     case XMGMT_ULP:
> > +             return xmm->firmware_ulp;
> > +     default:
> > +             xrt_err(xmm->pdev, "unknown axlf kind: %d", kind);
> > +             return NULL;
> > +     }
> > +}
> > +
> > +char *xmgmt_get_dtb(struct platform_device *pdev, enum provider_kind
kind)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +     char *dtb =3D NULL;
> > +     const char *provider =3D xmgmt_get_axlf_firmware(xmm, kind);
> > +     int rc;
> > +
> > +     if (provider =3D=3D NULL)
> > +             return dtb;
> > +
> > +     rc =3D xrt_xclbin_get_metadata(DEV(pdev), provider, &dtb);
> > +     if (rc)
> > +             xrt_err(pdev, "failed to find dtb: %d", rc);
> > +     return dtb;
> > +}
> > +
> > +static const char *get_uuid_from_firmware(struct platform_device *pdev=
,
> > +     const char *axlf)
> > +{
> > +     const void *uuid =3D NULL;
> > +     const void *uuiddup =3D NULL;
> > +     void *dtb =3D NULL;
> > +     int rc;
> > +
> > +     rc =3D xrt_xclbin_get_section(axlf, PARTITION_METADATA, &dtb, NUL=
L);
> > +     if (rc)
> > +             return NULL;
> > +
> > +     rc =3D xrt_md_get_prop(DEV(pdev), dtb, NULL, NULL,
> > +             PROP_LOGIC_UUID, &uuid, NULL);
> > +     if (!rc)
> > +             uuiddup =3D kstrdup(uuid, GFP_KERNEL);
> > +     vfree(dtb);
> > +     return uuiddup;
> > +}
> > +
> > +static bool is_valid_firmware(struct platform_device *pdev,
> > +     char *fw_buf, size_t fw_len)
> > +{
> > +     struct axlf *axlf =3D (struct axlf *)fw_buf;
> > +     size_t axlflen =3D axlf->m_header.m_length;
> > +     const char *fw_uuid;
> > +     char dev_uuid[80];
> > +     int err;
> > +
> > +     err =3D get_dev_uuid(pdev, dev_uuid, sizeof(dev_uuid));
> > +     if (err)
> > +             return false;
> > +
> > +     if (memcmp(fw_buf, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)) !=3D 0=
) {
> > +             xrt_err(pdev, "unknown fw format");
> > +             return false;
> > +     }
> > +
> > +     if (axlflen > fw_len) {
> > +             xrt_err(pdev, "truncated fw, length: %ld, expect: %ld",
> > +                     fw_len, axlflen);
> > +             return false;
> > +     }
> > +
> > +     fw_uuid =3D get_uuid_from_firmware(pdev, fw_buf);
> > +     if (fw_uuid =3D=3D NULL || strcmp(fw_uuid, dev_uuid) !=3D 0) {
> > +             xrt_err(pdev, "bad fw UUID: %s, expect: %s",
> > +                     fw_uuid ? fw_uuid : "<none>", dev_uuid);
> > +             kfree(fw_uuid);
> > +             return false;
> > +     }
> > +
> > +     kfree(fw_uuid);
> > +     return true;
> > +}
> > +
> > +int xmgmt_get_provider_uuid(struct platform_device *pdev,
> > +     enum provider_kind kind, uuid_t *uuid)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +     const char *fwbuf;
> > +     const char *fw_uuid;
> > +     int rc =3D -ENOENT;
> > +
> > +     mutex_lock(&xmm->busy_mutex);
> > +
> > +     fwbuf =3D xmgmt_get_axlf_firmware(xmm, kind);
> > +     if (fwbuf =3D=3D NULL)
> > +             goto done;
> > +
> > +     fw_uuid =3D get_uuid_from_firmware(pdev, fwbuf);
> > +     if (fw_uuid =3D=3D NULL)
> > +             goto done;
> > +
> > +     rc =3D xrt_md_uuid_strtoid(DEV(pdev), fw_uuid, uuid);
> > +     kfree(fw_uuid);
> > +
> > +done:
> > +     mutex_unlock(&xmm->busy_mutex);
> > +     return rc;
> > +}
> > +
> > +static int xmgmt_create_blp(struct xmgmt_main *xmm)
> > +{
> > +     struct platform_device *pdev =3D xmm->pdev;
> > +     int rc =3D 0;
> > +     char *dtb =3D NULL;
> > +
> > +     dtb =3D xmgmt_get_dtb(pdev, XMGMT_BLP);
> > +     if (dtb) {
> > +             rc =3D xrt_subdev_create_partition(pdev, dtb);
> > +             if (rc < 0)
> > +                     xrt_err(pdev, "failed to create BLP: %d", rc);
> > +             else
> > +                     rc =3D 0;
> > +
> > +             BUG_ON(xmm->blp_intf_uuids);
> > +             xrt_md_get_intf_uuids(&pdev->dev, dtb,
> > +                     &xmm->blp_intf_uuid_num, NULL);
> > +             if (xmm->blp_intf_uuid_num > 0) {
> > +                     xmm->blp_intf_uuids =3D vzalloc(sizeof(uuid_t) *
> > +                             xmm->blp_intf_uuid_num);
> > +                     xrt_md_get_intf_uuids(&pdev->dev, dtb,
> > +                             &xmm->blp_intf_uuid_num, xmm->blp_intf_uu=
ids);
> > +             }
> > +     }
> > +
> > +     vfree(dtb);
> > +     return rc;
> > +}
> > +
> > +static int xmgmt_main_event_cb(struct platform_device *pdev,
> > +     enum xrt_events evt, void *arg)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +     struct xrt_event_arg_subdev *esd =3D (struct xrt_event_arg_subdev
*)arg;
> > +     enum xrt_subdev_id id;
> > +     int instance;
> > +     size_t fwlen;
> > +
> > +     switch (evt) {
> > +     case XRT_EVENT_POST_CREATION: {
> > +             id =3D esd->xevt_subdev_id;
> > +             instance =3D esd->xevt_subdev_instance;
> > +             xrt_info(pdev, "processing event %d for (%d, %d)",
> > +                     evt, id, instance);
> > +
> > +             if (id =3D=3D XRT_SUBDEV_GPIO)
> > +                     xmm->gpio_ready =3D true;
> > +             else if (id =3D=3D XRT_SUBDEV_QSPI)
> > +                     xmm->flash_ready =3D true;
> > +             else
> > +                     BUG_ON(1);
> > +
> > +             if (xmm->gpio_ready && xmm->flash_ready) {
> > +                     int rc;
> > +
> > +                     rc =3D load_firmware_from_disk(pdev, &xmm->firmwa=
re_blp,
> > +                             &fwlen);
> > +                     if (rc !=3D 0) {
> > +                             rc =3D load_firmware_from_flash(pdev,
> > +                                     &xmm->firmware_blp, &fwlen);
> > +                     }
> > +                     if (rc =3D=3D 0 && is_valid_firmware(pdev,
> > +                         xmm->firmware_blp, fwlen))
> > +                             (void) xmgmt_create_blp(xmm);
> > +                     else
> > +                             xrt_err(pdev,
> > +                                     "failed to find firmware, giving =
up");
> > +                     xmm->evt_hdl =3D NULL;
> > +             }
> > +             break;
> > +     }
> > +     case XRT_EVENT_POST_ATTACH:
> > +             xmgmt_peer_notify_state(xmm->mailbox_hdl, true);
> > +             break;
> > +     case XRT_EVENT_PRE_DETACH:
> > +             xmgmt_peer_notify_state(xmm->mailbox_hdl, false);
> > +             break;
> > +     default:
> > +             xrt_info(pdev, "ignored event %d", evt);
> > +             break;
> > +     }
> > +
> > +     return XRT_EVENT_CB_CONTINUE;
> > +}
> > +
> > +static int xmgmt_main_probe(struct platform_device *pdev)
> > +{
> > +     struct xmgmt_main *xmm;
> > +
> > +     xrt_info(pdev, "probing...");
> > +
> > +     xmm =3D devm_kzalloc(DEV(pdev), sizeof(*xmm), GFP_KERNEL);
> > +     if (!xmm)
> > +             return -ENOMEM;
> > +
> > +     xmm->pdev =3D pdev;
> > +     platform_set_drvdata(pdev, xmm);
> > +     xmm->fmgr =3D xmgmt_fmgr_probe(pdev);
> > +     xmm->mailbox_hdl =3D xmgmt_mailbox_probe(pdev);
> > +     mutex_init(&xmm->busy_mutex);
> > +
> > +     xmm->evt_hdl =3D xrt_subdev_add_event_cb(pdev,
> > +             xmgmt_main_leaf_match, NODE_BLP_ROM,
xmgmt_main_event_cb);
> > +
> > +     /* Ready to handle req thru sysfs nodes. */
> > +     if (sysfs_create_group(&DEV(pdev)->kobj, &xmgmt_main_attrgroup))
> > +             xrt_err(pdev, "failed to create sysfs group");
> > +     return 0;
> > +}
> > +
> > +static int xmgmt_main_remove(struct platform_device *pdev)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +
> > +     /* By now, partition driver should prevent any inter-leaf call. *=
/
> > +
> > +     xrt_info(pdev, "leaving...");
> > +
> > +     if (xmm->evt_hdl)
> > +             (void) xrt_subdev_remove_event_cb(pdev, xmm->evt_hdl);
> > +     vfree(xmm->blp_intf_uuids);
> > +     vfree(xmm->firmware_blp);
> > +     vfree(xmm->firmware_plp);
> > +     vfree(xmm->firmware_ulp);
> > +     (void) xmgmt_fmgr_remove(xmm->fmgr);
> > +     xmgmt_mailbox_remove(xmm->mailbox_hdl);
> > +     (void) sysfs_remove_group(&DEV(pdev)->kobj,
&xmgmt_main_attrgroup);
> > +     return 0;
> > +}
> > +
> > +static int
> > +xmgmt_main_leaf_ioctl(struct platform_device *pdev, u32 cmd, void
*arg)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +     int ret =3D 0;
> > +
> > +     xrt_info(pdev, "handling IOCTL cmd: %d", cmd);
> > +
> > +     switch (cmd) {
> > +     case XRT_MGMT_MAIN_GET_AXLF_SECTION: {
> > +             struct xrt_mgmt_main_ioctl_get_axlf_section *get =3D
> > +                     (struct xrt_mgmt_main_ioctl_get_axlf_section *)ar=
g;
> > +             const char *firmware =3D
> > +                     xmgmt_get_axlf_firmware(xmm, get->xmmigas_axlf_ki=
nd);
> > +
> > +             if (firmware =3D=3D NULL) {
> > +                     ret =3D -ENOENT;
> > +             } else {
> > +                     ret =3D xrt_xclbin_get_section(firmware,
> > +                             get->xmmigas_section_kind,
> > +                             &get->xmmigas_section,
> > +                             &get->xmmigas_section_size);
> > +             }
> > +             break;
> > +     }
> > +     case XRT_MGMT_MAIN_GET_VBNV: {
> > +             char **vbnv_p =3D (char **)arg;
> > +
> > +             *vbnv_p =3D xmgmt_get_vbnv(pdev);
> > +             break;
> > +     }
> > +     default:
> > +             xrt_err(pdev, "unknown cmd: %d", cmd);
> > +             ret =3D -EINVAL;
> > +             break;
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int xmgmt_main_open(struct inode *inode, struct file *file)
> > +{
> > +     struct platform_device *pdev =3D xrt_devnode_open(inode);
> > +
> > +     /* Device may have gone already when we get here. */
> > +     if (!pdev)
> > +             return -ENODEV;
> > +
> > +     xrt_info(pdev, "opened");
> > +     file->private_data =3D platform_get_drvdata(pdev);
> > +     return 0;
> > +}
> > +
> > +static int xmgmt_main_close(struct inode *inode, struct file *file)
> > +{
> > +     struct xmgmt_main *xmm =3D file->private_data;
> > +
> > +     xrt_devnode_close(inode);
> > +
> > +     xrt_info(xmm->pdev, "closed");
> > +     return 0;
> > +}
> > +
> > +static int xmgmt_bitstream_axlf_fpga_mgr(struct xmgmt_main *xmm,
> > +     void *axlf, size_t size)
> > +{
> > +     int ret;
> > +     struct fpga_image_info info =3D { 0 };
> > +
> > +     BUG_ON(!mutex_is_locked(&xmm->busy_mutex));
> > +
> > +     /*
> > +      * Should any error happens during download, we can't trust
> > +      * the cached xclbin any more.
> > +      */
> > +     vfree(xmm->firmware_ulp);
> > +     xmm->firmware_ulp =3D NULL;
> > +
> > +     info.buf =3D (char *)axlf;
> > +     info.count =3D size;
> > +     ret =3D fpga_mgr_load(xmm->fmgr, &info);
> > +     if (ret =3D=3D 0)
> > +             xmm->firmware_ulp =3D axlf;
> > +
> > +     return ret;
> > +}
> > +
> > +int bitstream_axlf_mailbox(struct platform_device *pdev, const void *a=
xlf)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +     void *copy_buffer =3D NULL;
> > +     size_t copy_buffer_size =3D 0;
> > +     const struct axlf *xclbin_obj =3D axlf;
> > +     int ret =3D 0;
> > +
> > +     if (memcmp(xclbin_obj->m_magic, ICAP_XCLBIN_V2,
sizeof(ICAP_XCLBIN_V2)))
> > +             return -EINVAL;
> > +
> > +     copy_buffer_size =3D xclbin_obj->m_header.m_length;
> > +     if (copy_buffer_size > MAX_XCLBIN_SIZE)
> > +             return -EINVAL;
> > +     copy_buffer =3D vmalloc(copy_buffer_size);
> > +     if (copy_buffer =3D=3D NULL)
> > +             return -ENOMEM;
> > +     (void) memcpy(copy_buffer, axlf, copy_buffer_size);
> > +
> > +     mutex_lock(&xmm->busy_mutex);
> > +     ret =3D xmgmt_bitstream_axlf_fpga_mgr(xmm, copy_buffer,
copy_buffer_size);
> > +     mutex_unlock(&xmm->busy_mutex);
> > +     if (ret)
> > +             vfree(copy_buffer);
> > +     return ret;
> > +}
> > +
> > +static int bitstream_axlf_ioctl(struct xmgmt_main *xmm, const void
__user *arg)
> > +{
> > +     void *copy_buffer =3D NULL;
> > +     size_t copy_buffer_size =3D 0;
> > +     struct xmgmt_ioc_bitstream_axlf ioc_obj =3D { 0 };
> > +     struct axlf xclbin_obj =3D { {0} };
> > +     int ret =3D 0;
> > +
> > +     if (copy_from_user((void *)&ioc_obj, arg, sizeof(ioc_obj)))
> > +             return -EFAULT;
> > +     if (copy_from_user((void *)&xclbin_obj, ioc_obj.xclbin,
> > +             sizeof(xclbin_obj)))
> > +             return -EFAULT;
> > +     if (memcmp(xclbin_obj.m_magic, ICAP_XCLBIN_V2,
sizeof(ICAP_XCLBIN_V2)))
> > +             return -EINVAL;
> > +
> > +     copy_buffer_size =3D xclbin_obj.m_header.m_length;
> > +     if (copy_buffer_size > MAX_XCLBIN_SIZE)
> > +             return -EINVAL;
> > +     copy_buffer =3D vmalloc(copy_buffer_size);
> > +     if (copy_buffer =3D=3D NULL)
> > +             return -ENOMEM;
> > +
> > +     if (copy_from_user(copy_buffer, ioc_obj.xclbin, copy_buffer_size)=
) {
> > +             vfree(copy_buffer);
> > +             return -EFAULT;
> > +     }
> > +
> > +     ret =3D xmgmt_bitstream_axlf_fpga_mgr(xmm, copy_buffer,
copy_buffer_size);
> > +     if (ret)
> > +             vfree(copy_buffer);
> > +
> > +     return ret;
> > +}
> > +
> > +static long xmgmt_main_ioctl(struct file *filp, unsigned int cmd,
> > +     unsigned long arg)
> > +{
> > +     long result =3D 0;
> > +     struct xmgmt_main *xmm =3D filp->private_data;
> > +
> > +     BUG_ON(!xmm);
> > +
> > +     if (_IOC_TYPE(cmd) !=3D XMGMT_IOC_MAGIC)
> > +             return -ENOTTY;
> > +
> > +     mutex_lock(&xmm->busy_mutex);
> > +
> > +     xrt_info(xmm->pdev, "ioctl cmd %d, arg %ld", cmd, arg);
> > +     switch (cmd) {
> > +     case XMGMT_IOCICAPDOWNLOAD_AXLF:
> > +             result =3D bitstream_axlf_ioctl(xmm, (const void __user *=
)arg);
> > +             break;
> > +     default:
> > +             result =3D -ENOTTY;
> > +             break;
> > +     }
> > +
> > +     mutex_unlock(&xmm->busy_mutex);
> > +     return result;
> > +}
> > +
> > +void *xmgmt_pdev2mailbox(struct platform_device *pdev)
> > +{
> > +     struct xmgmt_main *xmm =3D platform_get_drvdata(pdev);
> > +
> > +     return xmm->mailbox_hdl;
> > +}
> > +
> > +struct xrt_subdev_endpoints xrt_mgmt_main_endpoints[] =3D {
> > +     {
> > +             .xse_names =3D (struct xrt_subdev_ep_names []){
> > +                     { .ep_name =3D NODE_MGMT_MAIN },
> > +                     { NULL },
> > +             },
> > +             .xse_min_ep =3D 1,
> > +     },
> > +     { 0 },
> > +};
> > +
> > +struct xrt_subdev_drvdata xmgmt_main_data =3D {
> > +     .xsd_dev_ops =3D {
> > +             .xsd_ioctl =3D xmgmt_main_leaf_ioctl,
> > +     },
> > +     .xsd_file_ops =3D {
> > +             .xsf_ops =3D {
> > +                     .owner =3D THIS_MODULE,
> > +                     .open =3D xmgmt_main_open,
> > +                     .release =3D xmgmt_main_close,
> > +                     .unlocked_ioctl =3D xmgmt_main_ioctl,
> > +             },
> > +             .xsf_dev_name =3D "xmgmt",
> > +     },
> > +};
> > +
> > +static const struct platform_device_id xmgmt_main_id_table[] =3D {
> > +     { XMGMT_MAIN, (kernel_ulong_t)&xmgmt_main_data },
> > +     { },
> > +};
> > +
> > +struct platform_driver xmgmt_main_driver =3D {
> > +     .driver =3D {
> > +             .name    =3D XMGMT_MAIN,
> > +     },
> > +     .probe   =3D xmgmt_main_probe,
> > +     .remove  =3D xmgmt_main_remove,
> > +     .id_table =3D xmgmt_main_id_table,
> > +};
> > diff --git a/drivers/fpga/alveo/mgmt/xmgmt-root.c
b/drivers/fpga/alveo/mgmt/xmgmt-root.c
> > new file mode 100644
> > index 000000000000..005fd5e42651
> > --- /dev/null
> > +++ b/drivers/fpga/alveo/mgmt/xmgmt-root.c
> > @@ -0,0 +1,375 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx Alveo Management Function Driver
> > + *
> > + * Copyright (C) 2020 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *   Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/aer.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/delay.h>
> > +
> > +#include "xrt-root.h"
> > +#include "xrt-subdev.h"
> > +#include "xmgmt-main-impl.h"
> > +#include "xrt-metadata.h"
> > +
> > +#define      XMGMT_MODULE_NAME       "xmgmt"
> > +#define      XMGMT_DRIVER_VERSION    "4.0.0"
> > +
> > +#define      XMGMT_PDEV(xm)          ((xm)->pdev)
> > +#define      XMGMT_DEV(xm)           (&(XMGMT_PDEV(xm)->dev))
> > +#define xmgmt_err(xm, fmt, args...)  \
> > +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define xmgmt_warn(xm, fmt, args...) \
> > +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define xmgmt_info(xm, fmt, args...) \
> > +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define xmgmt_dbg(xm, fmt, args...)  \
> > +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > +#define      XMGMT_DEV_ID(pdev)                      \
> > +     ((pci_domain_nr(pdev->bus) << 16) |     \
> > +     PCI_DEVID(pdev->bus->number, 0))
> > +
> > +static struct class *xmgmt_class;
> > +static const struct pci_device_id xmgmt_pci_ids[] =3D {
> > +     { PCI_DEVICE(0x10EE, 0xd020), },
> > +     { PCI_DEVICE(0x10EE, 0x5020), },
> > +     { 0, }
> > +};
> > +
> > +struct xmgmt {
> > +     struct pci_dev *pdev;
> > +     void *root;
> > +
> > +     /* save config for pci reset */
> > +     u32 saved_config[8][16];
> > +     bool ready;
> > +};
> > +
> > +static int xmgmt_config_pci(struct xmgmt *xm)
> > +{
> > +     struct pci_dev *pdev =3D XMGMT_PDEV(xm);
> > +     int rc;
> > +
> > +     rc =3D pcim_enable_device(pdev);
> > +     if (rc < 0) {
> > +             xmgmt_err(xm, "failed to enable device: %d", rc);
> > +             return rc;
> > +     }
> > +
> > +     rc =3D pci_enable_pcie_error_reporting(pdev);
> > +     if (rc)
> > +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
> > +
> > +     pci_set_master(pdev);
> > +
> > +     rc =3D pcie_get_readrq(pdev);
> > +     if (rc < 0) {
> > +             xmgmt_err(xm, "failed to read mrrs %d", rc);
> > +             return rc;
> > +     }
> > +     if (rc > 512) {
> > +             rc =3D pcie_set_readrq(pdev, 512);
> > +             if (rc) {
> > +                     xmgmt_err(xm, "failed to force mrrs %d", rc);
> > +                     return rc;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void xmgmt_save_config_space(struct pci_dev *pdev, u32
*saved_config)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < 16; i++)
> > +             pci_read_config_dword(pdev, i * 4, &saved_config[i]);
> > +}
> > +
> > +static int xmgmt_match_slot_and_save(struct device *dev, void *data)
> > +{
> > +     struct xmgmt *xm =3D data;
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +
> > +     if (XMGMT_DEV_ID(pdev) =3D=3D XMGMT_DEV_ID(xm->pdev)) {
> > +             pci_cfg_access_lock(pdev);
> > +             pci_save_state(pdev);
> > +             xmgmt_save_config_space(pdev,
> > +                     xm->saved_config[PCI_FUNC(pdev->devfn)]);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void xmgmt_pci_save_config_all(struct xmgmt *xm)
> > +{
> > +     bus_for_each_dev(&pci_bus_type, NULL, xm,
xmgmt_match_slot_and_save);
> > +}
> > +
> > +static void xmgmt_restore_config_space(struct pci_dev *pdev, u32
*config_saved)
> > +{
> > +     int i;
> > +     u32 val;
> > +
> > +     for (i =3D 0; i < 16; i++) {
> > +             pci_read_config_dword(pdev, i * 4, &val);
> > +             if (val =3D=3D config_saved[i])
> > +                     continue;
> > +
> > +             pci_write_config_dword(pdev, i * 4, config_saved[i]);
> > +             pci_read_config_dword(pdev, i * 4, &val);
> > +             if (val !=3D config_saved[i]) {
> > +                     dev_err(&pdev->dev,
> > +                              "restore config at %d failed", i * 4);
> > +             }
> > +     }
> > +}
> > +
> > +static int xmgmt_match_slot_and_restore(struct device *dev, void *data=
)
> > +{
> > +     struct xmgmt *xm =3D data;
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +
> > +     if (XMGMT_DEV_ID(pdev) =3D=3D XMGMT_DEV_ID(xm->pdev)) {
> > +             xmgmt_restore_config_space(pdev,
> > +                     xm->saved_config[PCI_FUNC(pdev->devfn)]);
> > +
> > +             pci_restore_state(pdev);
> > +             pci_cfg_access_unlock(pdev);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
> > +{
> > +     bus_for_each_dev(&pci_bus_type, NULL, xm,
xmgmt_match_slot_and_restore);
> > +}
> > +
> > +void xroot_hot_reset(struct pci_dev *pdev)
> > +{
> > +     struct xmgmt *xm =3D pci_get_drvdata(pdev);
> > +     struct pci_bus *bus;
> > +     u8 pci_bctl;
> > +     u16 pci_cmd, devctl;
> > +     int i;
> > +
> > +     xmgmt_info(xm, "hot reset start");
> > +
> > +     xmgmt_pci_save_config_all(xm);
> > +
> > +     pci_disable_device(pdev);
> > +
> > +     bus =3D pdev->bus;
> > +
> > +     /*
> > +      * When flipping the SBR bit, device can fall off the bus. This i=
s
> > +      * usually no problem at all so long as drivers are working prope=
rly
> > +      * after SBR. However, some systems complain bitterly when the de=
vice
> > +      * falls off the bus.
> > +      * The quick solution is to temporarily disable the SERR reportin=
g of
> > +      * switch port during SBR.
> > +      */
> > +
> > +     pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
> > +     pci_write_config_word(bus->self, PCI_COMMAND,
> > +             (pci_cmd & ~PCI_COMMAND_SERR));
> > +     pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
> > +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL,
> > +             (devctl & ~PCI_EXP_DEVCTL_FERE));
> > +     pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
> > +     pci_bctl |=3D PCI_BRIDGE_CTL_BUS_RESET;
> > +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
> > +
> > +     msleep(100);
> > +     pci_bctl &=3D ~PCI_BRIDGE_CTL_BUS_RESET;
> > +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
> > +     ssleep(1);
> > +
> > +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
> > +     pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
> > +
> > +     pci_enable_device(pdev);
> > +
> > +     for (i =3D 0; i < 300; i++) {
> > +             pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
> > +             if (pci_cmd !=3D 0xffff)
> > +                     break;
> > +             msleep(20);
> > +     }
> > +
> > +     xmgmt_info(xm, "waiting for %d ms", i * 20);
> > +
> > +     xmgmt_pci_restore_config_all(xm);
> > +
> > +     xmgmt_config_pci(xm);
> > +}
> > +
> > +static int xmgmt_create_root_metadata(struct xmgmt *xm, char
**root_dtb)
> > +{
> > +     char *dtb =3D NULL;
> > +     int ret;
> > +
> > +     ret =3D xrt_md_create(DEV(xm->pdev), &dtb);
> > +     if (ret) {
> > +             xmgmt_err(xm, "create metadata failed, ret %d", ret);
> > +             goto failed;
> > +     }
> > +
> > +     ret =3D xroot_add_simple_node(xm->root, dtb, NODE_TEST);
> > +     if (ret)
> > +             goto failed;
> > +
> > +     ret =3D xroot_add_vsec_node(xm->root, dtb);
> > +     if (ret =3D=3D -ENOENT) {
> > +             /*
> > +              * We may be dealing with a MFG board.
> > +              * Try vsec-golden which will bring up all hard-coded lea=
ves
> > +              * at hard-coded offsets.
> > +              */
> > +             ret =3D xroot_add_simple_node(xm, dtb, NODE_VSEC_GOLDEN);
> > +     } else if (ret =3D=3D 0) {
> > +             ret =3D xroot_add_simple_node(xm->root, dtb,
NODE_MGMT_MAIN);
> > +     }
> > +     if (ret)
> > +             goto failed;
> > +
> > +     *root_dtb =3D dtb;
> > +     return 0;
> > +
> > +failed:
> > +     vfree(dtb);
> > +     return ret;
> > +}
> > +
> > +static ssize_t ready_show(struct device *dev,
> > +     struct device_attribute *da, char *buf)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +     struct xmgmt *xm =3D pci_get_drvdata(pdev);
> > +
> > +     return sprintf(buf, "%d\n", xm->ready);
> > +}
> > +static DEVICE_ATTR_RO(ready);
> > +
> > +static struct attribute *xmgmt_root_attrs[] =3D {
> > +     &dev_attr_ready.attr,
> > +     NULL
> > +};
> > +
> > +static struct attribute_group xmgmt_root_attr_group =3D {
> > +     .attrs =3D xmgmt_root_attrs,
> > +};
> > +
> > +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_i=
d
*id)
> > +{
> > +     int ret;
> > +     struct device *dev =3D DEV(pdev);
> > +     struct xmgmt *xm =3D devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
> > +     char *dtb =3D NULL;
> > +
> > +     if (!xm)
> > +             return -ENOMEM;
> > +     xm->pdev =3D pdev;
> > +     pci_set_drvdata(pdev, xm);
> > +
> > +     ret =3D xmgmt_config_pci(xm);
> > +     if (ret)
> > +             goto failed;
> > +
> > +     ret =3D xroot_probe(pdev, &xm->root);
> > +     if (ret)
> > +             goto failed;
> > +
> > +     ret =3D xmgmt_create_root_metadata(xm, &dtb);
> > +     if (ret)
> > +             goto failed_metadata;
> > +
> > +     ret =3D xroot_create_partition(xm->root, dtb);
> > +     vfree(dtb);
> > +     if (ret)
> > +             xmgmt_err(xm, "failed to create root partition: %d", ret)=
;
> > +
> > +     if (!xroot_wait_for_bringup(xm->root))
> > +             xmgmt_err(xm, "failed to bringup all partitions");
> > +     else
> > +             xm->ready =3D true;
> > +
> > +     ret =3D sysfs_create_group(&pdev->dev.kobj, &xmgmt_root_attr_grou=
p);
> > +     if (ret) {
> > +             /* Warning instead of failing the probe. */
> > +             xrt_warn(pdev, "create xmgmt root attrs failed: %d", ret)=
;
> > +     }
> > +
> > +     xroot_broadcast(xm->root, XRT_EVENT_POST_ATTACH);
> > +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
> > +     return 0;
> > +
> > +failed_metadata:
> > +     (void) xroot_remove(xm->root);
> > +failed:
> > +     pci_set_drvdata(pdev, NULL);
> > +     return ret;
> > +}
> > +
> > +static void xmgmt_remove(struct pci_dev *pdev)
> > +{
> > +     struct xmgmt *xm =3D pci_get_drvdata(pdev);
> > +
> > +     xroot_broadcast(xm->root, XRT_EVENT_PRE_DETACH);
> > +     sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
> > +     (void) xroot_remove(xm->root);
> > +     pci_disable_pcie_error_reporting(xm->pdev);
> > +     xmgmt_info(xm, "%s cleaned up successfully",
XMGMT_MODULE_NAME);
> > +}
> > +
> > +static struct pci_driver xmgmt_driver =3D {
> > +     .name =3D XMGMT_MODULE_NAME,
> > +     .id_table =3D xmgmt_pci_ids,
> > +     .probe =3D xmgmt_probe,
> > +     .remove =3D xmgmt_remove,
> > +};
> > +
> > +static int __init xmgmt_init(void)
> > +{
> > +     int res =3D
xrt_subdev_register_external_driver(XRT_SUBDEV_MGMT_MAIN,
> > +             &xmgmt_main_driver, xrt_mgmt_main_endpoints);
> > +
> > +     if (res)
> > +             return res;
> > +
> > +     xmgmt_class =3D class_create(THIS_MODULE,
XMGMT_MODULE_NAME);
> > +     if (IS_ERR(xmgmt_class))
> > +             return PTR_ERR(xmgmt_class);
> > +
> > +     res =3D pci_register_driver(&xmgmt_driver);
> > +     if (res) {
> > +             class_destroy(xmgmt_class);
> > +             return res;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static __exit void xmgmt_exit(void)
> > +{
> > +     pci_unregister_driver(&xmgmt_driver);
> > +     class_destroy(xmgmt_class);
> > +     xrt_subdev_unregister_external_driver(XRT_SUBDEV_MGMT_MAIN);
> > +}
> > +
> > +module_init(xmgmt_init);
> > +module_exit(xmgmt_exit);
> > +
> > +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
> > +MODULE_VERSION(XMGMT_DRIVER_VERSION);
> > +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> > +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
>
> I have not yet looked at the whole thing, but why does the FPGA Manager
> only copy things around?
>
> Any reason your partitions cannot be modelled as FPGA regions/Bridges?
>

We will address this as Max explained in the other email.

> It would be helpful to split this up into smaller chunks, that make it
> easier to review. The FPGA Manager driver should be a separate patch,
> etc.
>

Will resolve in the next revision of the patch series.

Thanks for your feedback.
-Sonal

> - Moritz
> =20
