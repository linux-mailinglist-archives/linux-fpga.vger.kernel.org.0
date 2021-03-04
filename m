Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598A432CD7F
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 08:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhCDHWh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 02:22:37 -0500
Received: from mail-dm3nam07on2055.outbound.protection.outlook.com ([40.107.95.55]:42976
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236198AbhCDHWO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 02:22:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLHdsfG6INAgWVdEbJD/mrLBfxJdRKtqgciegdpOu43R4I3X3gWcvS72n0Zr2ELVzJUsJhQWlCJV+IP9YPBa2iIx+06s3irHX6uYuvVdSQiqx8OrpPjEz6BTYJ4mVQ48ZeyAjDAKQNeXctCXDxR4AxM3hfgDS1pT1LsIhUkPVOK0//6QSsr4FD7ML/wRoPb1ClUao/Q4pxtzQjq4mVoLsXZrIrllzECBXqVm2IqMvfppffDoUyDOGGu+CWP9+8hT9BvEkOhHWSb+i0mXy+gKnXKfRNLz3BdtjYjD+4/5h5CYFmtnfy+E2K9LNqQPZiV/sQnkHXHyz7nx5GKMOBZ/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mljoC9d9VmQvUKwMmMusbpz4aUvvt4RdbVq1mMJKBB0=;
 b=dZyeKufqPW+tzYewswkm4WekQfAfn+qfpIMa0ZfLFbtRRulX91CDmi/MufB+eYpv9QpHWl666HzfCsEwCGYsX/+M8TpirER3/pbR1KgRBJbnMbRoxmzz6SgxrKkGNs9qndGHkbnrOKQlS9MnhjrDI5q6+go9SQoPNMoWpE37iUejpsL9stNZC2gWL6A7TYPXzx3ux2GdiJdJY6HoBHYP0XFWWzHIgcGeTAI4XnK2ybkRruvwMoYFzp2bpilvdQSvpV7vjNye9Dz4pKsIoaWhqmllaoQpyo3D72FLKN/i8fFnR3pPS37T3bP789rG5XE8ZlnQGp7+fOvWV2oh5oIfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mljoC9d9VmQvUKwMmMusbpz4aUvvt4RdbVq1mMJKBB0=;
 b=bJ7HKMBVMx8qYqVgtTroHX2SZjnnYJkbEfp1aqPzOreHgv7XpL0v5KXogwKNTrMZbqGHDpX/T9kiFpTIUjFjz31sanCKXq3NSxPeqAam8lVu+YWHn6ed1MvsyRwrLyECjMn32FIsGoK8zHI4I93DKfTxcnnANs5mVFQmHW+g2T0=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2317.namprd02.prod.outlook.com (2603:10b6:300:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 4 Mar
 2021 07:21:21 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 07:21:21 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
CC:     git <git@xilinx.com>
Subject: RE: [PATCH v2 0/2] Add DFX AXI Shutdown manager IP support for Xilinx
Thread-Topic: [PATCH v2 0/2] Add DFX AXI Shutdown manager IP support for
 Xilinx
Thread-Index: AQHXADVYKfdNXFvF5k+nT8eyko1p1qpzjWAQ
Date:   Thu, 4 Mar 2021 07:21:21 +0000
Message-ID: <MWHPR02MB2623671095460019231CB4EDC2979@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210211051148.16722-1-nava.manne@xilinx.com>
In-Reply-To: <20210211051148.16722-1-nava.manne@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5eed862c-716d-4c44-0067-08d8dede1c44
x-ms-traffictypediagnostic: MWHPR02MB2317:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2317180C3BF3F75CC1468CC1C2979@MWHPR02MB2317.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dgDtGg82cHCZN30AnM84lJzuT5Tc6s5hOLfpeTAQlFp0YZmXFOhcChYptrZWtfH+c/sZiplHh6xiW6PfRBgY/KxzZPSCo+05P8mPTXErasd/H8OFZY5lzYT0b7oMpiP5epkc19R/1t2SJesAApGoMYD72h249YyC/VKVw9L9hWObpyK9XLbGQ9FfvlBpgyqLsywgRdSuiLAZ274M2pmKBROXrvcFGRqrLQB0dP47woUTsTTiqLfr1RCCrpa/y2ogN/Xyv1m9aS3t6/cFiyleaHjWqYz5rRZQC0FXXBws6FIzKEYRuzE6tro4t7MixBeoaBk7KDg4xB5fsDOgSwupPP1FuyW7KF3R6o6N7gKP9K7oJkgibwLJIzBgLloBbVGmWXLc+dDCIYyeEfafW7Fn/+ZfWxpqBe6GorMfguVjwDDmuNpcl0dzifwJdKMs+CHlR+kauhf9KcuX1nUDEvwVJ3UQ9YfbKJo/OiE4WpKiN0NVZEZhuwXgWleWER+4b9uf39sNqJTvGz5tVkPC6Lgz+viLt34pOEQ4VwPBhSNUbK9/kx94RuOXvCf8ZUVPx2/T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(110136005)(53546011)(4744005)(26005)(478600001)(186003)(6506007)(7696005)(64756008)(86362001)(316002)(107886003)(8676002)(55016002)(9686003)(66946007)(2906002)(921005)(71200400001)(66476007)(66446008)(76116006)(52536014)(66556008)(8936002)(33656002)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GME7G3PDHBurxJWAKvBbQ5fhP322FqGQ39tL4/8c0LzzhAiQSeIl78o7FdBn?=
 =?us-ascii?Q?NSiuYCAczDwgqY6mDYFhhrfUuy1wtG9uJ76uEXbbf8bBZRIt++F+++ZKOZB/?=
 =?us-ascii?Q?CUb/wkGNNGCIJqmL8pCI7Hx5j+G6LS0VtruZYiWyhakFxPN6775yKJH1LOlq?=
 =?us-ascii?Q?4azbPZg5/Yj2e3tvhpeltkqrpIBAIt0IbkqbqaRgJ9n/KHv/xcOYcXHDfR6j?=
 =?us-ascii?Q?1LkyaUb8Nf5rMxQpxnnJeDGok0xnUDfyQ3lZlsq1v9sWDZr8jdgP+LFxI4Ri?=
 =?us-ascii?Q?fS8oJMoxz5neyQrfm/dl7A2Sp1taa5A05K4IJUhxXDa1jZ/N896Iz7rNog3e?=
 =?us-ascii?Q?2wq7OYcAkCMS3F5HZ2v1fUiSIn85UuaAbCjnzZwny6n5BfOCQR6qEqkgt6S4?=
 =?us-ascii?Q?8415febcT697fOEef6NJ0tPOQOnOif+MLfRRZbcgjl3njbR4gu0yCAlJ2Ou7?=
 =?us-ascii?Q?0ntU0nWEUpID1kgg608TwVHZVD7YF8hHZgmtnWaYDpqhDBW9+D8mV76YfWDE?=
 =?us-ascii?Q?DuHSQUpORJUfk0kirG2lcu7Y95Ct4+fwuFQ9WT4NgRBB7giQZaKRq8QkCfLN?=
 =?us-ascii?Q?f8dEIIiZk2Yg2dhT1c85TJnV5Ty8iStQ2PQ6TQxFf6HfETextHDTFUqJnNN7?=
 =?us-ascii?Q?T+e0ZZ7tuOEp/XjMupxWbwWWY+AjXBJcxdKUAhs5KI6GerQkrXg23gsaLJ8v?=
 =?us-ascii?Q?Bkxp1+tOutDkAotFu+nslxIofeaSrfURA0SIeEEFgAqyX6Jb5FuGuzqCkWhB?=
 =?us-ascii?Q?QauNAWsS5YyZPOmIYe+ylaBLrRX4BXJy4BOx57XXlLp2Zo5f12OMuCMHNngE?=
 =?us-ascii?Q?L7BGPazEO3sfiKrz262h4zGxw8felHqE8RE4aOC9nw2gfbmtqGRk7engVdMz?=
 =?us-ascii?Q?1MGVPsulrBFwVAmzDUJK5+1FzYxBCG90g8Ap+s9NR8C6FxjpP2gyJTXkdwry?=
 =?us-ascii?Q?CH8X1BJafozjlgeocOWRFLJNUHSbHOLC7dlQNQUgVp0liQUe/mEMOelB22I1?=
 =?us-ascii?Q?QVZkqYsjDTG/nQbxvt+Et7XA5bsa8xjxSSNH3NpFScRa2stkjHAPmdlqpaxK?=
 =?us-ascii?Q?NCf8ZoREVdgZqpmqe5tIZRxW260tOcL2Qwt216wcHc7wsT6MI+qFh6tOJBSa?=
 =?us-ascii?Q?W19QqgV8h8Q4Nz/tBWJAEAoC0HxVJNm5ocCqpPX79Uq4YeD/TMj2avJRLQDU?=
 =?us-ascii?Q?2Kp84Xxxj7Gb/pkGrG9ITOekQx5W446ebWjpxaGkLH0yq+TbDk10dN+9j24O?=
 =?us-ascii?Q?IPG9c+pRZ85NpuLwp6FWlu/8L7pT6Z/taPY18ItBbM+jribF6Ja/TNJNyA4O?=
 =?us-ascii?Q?tzYhCc3hkyjfkTIFxke19qSu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eed862c-716d-4c44-0067-08d8dede1c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:21:21.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utxzwdbxgQX5LopZPK/deFnsrC6DPpU8ed0m8EJ6Eksvz67QTLe1fq+E2a1VmhnWhYtHtYVAde1pl20gZjYn7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2317
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne <nava.manne@xilinx.com>
> Sent: Thursday, February 11, 2021 10:42 AM
> To: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; chinnikishore369@gmail.com
> Cc: git <git@xilinx.com>; Nava kishore Manne <navam@xilinx.com>
> Subject: [PATCH v2 0/2] Add DFX AXI Shutdown manager IP support for Xilin=
x
>=20
> Nava kishore Manne (2):
>   dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown
>     manager
>   fpga: Add support for Xilinx DFX AXI Shutdown manager
>=20
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 24 +++++++++++-
>  drivers/fpga/Kconfig                          |  9 ++++-
>  drivers/fpga/xilinx-pr-decoupler.c            | 37 ++++++++++++++++---
>  3 files changed, 63 insertions(+), 7 deletions(-)
>=20
> --
> 2.18.0

