Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDE53F59C
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jun 2022 07:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiFGFmR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jun 2022 01:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiFGFmQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jun 2022 01:42:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350593BC;
        Mon,  6 Jun 2022 22:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJGpXxprEv0f3f+F6J0N5U/ll2ECdssQXhf7nTa88FIjYwhq7aIwBz2x7xdVhEnERcjiUSptX2Znj86JrAUwVcyvmOeOUX+OVGcgfzTwMbKw62OPmML0TvARjO/exd2RtfPk48MnmuezsT3DpOieyR24sivV4Rf0iE7cLGa0zF08YszXR1CdS9+gRzokb/Uo/sl/X3xdN/EuxOz8c0ZqO2togQr6Xv/n2AOY0fQY38CeAziHFO0K19NA+Dz+2x0N7TRtb5gihRWsOHLEqMGuTr4NIzN7h/FSoYB1NxTvsbOtROo4C0xCIcaApmHjJRwUlZ6s/cDCptG34anggcZalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ryv5iQjdB++96PtxaMIYvOADYziwMO0SFBoDh8N+/I=;
 b=fLDoLISJRtEbFK1kD0addd2PKuNELtabSfmTY01ckedEGh9iLCuAQ3UuFchPKWXPGobz55yKibzB5/fMKjhf+uI6hZ3ZP6WqEU1WXTMwkp525MQvGICrn870WLfReRIkr3tYVCphZ33jjmfrguw0/pXCTWtRBSPbjcRKP/kJFCBvhK3WZdNr4QAgMOuw+WT51b0VWVlsVW37jxNsS4fK3NyRXnSYSBhk7fOakwsNDE11TZ/6RzBr6vlNin8Lbs3yYZciI20hBNQ9oIcJensUukVZyRVC4hBu86MSVraJUKvmERRiacLnLjDoeakwe1jZ7ChVuArlJtgQXkOCdsBDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ryv5iQjdB++96PtxaMIYvOADYziwMO0SFBoDh8N+/I=;
 b=Vg0Omu1hPTQaq8opNdj7jD/4G2XaeiVv3nUN9sePTK5HR4M+t3iYAp2/S5lBIegnXTKdene2MA/H/hMVFxdpq2CHqvVhn5KbMVSUCDMN20FcFq7EY+uojcRl43MSFeDdnmroMB1Fd39jR5HhZddnzUnvTdeA6O4uUoXTFmT7RBw=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BN6PR02MB2611.namprd02.prod.outlook.com (2603:10b6:404:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 05:41:54 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::b165:2ef9:a5a:d590]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::b165:2ef9:a5a:d590%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 05:41:54 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ronak Jain <ronakj@xilinx.com>,
        Abhyuday Godhasara <agodhasa@xilinx.com>,
        Rajan Vaja <rajanv@xlnx.xilinx.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Piyush Mehta <piyushm@xilinx.com>,
        Harsha Harsha <harshah@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH 3/3] fpga: zynqmp-fpga: Adds status interface
Thread-Topic: [PATCH 3/3] fpga: zynqmp-fpga: Adds status interface
Thread-Index: AQHYb1Nufvf7WOmZa0mceENJBTongK00bouAgA8TksA=
Date:   Tue, 7 Jun 2022 05:41:54 +0000
Message-ID: <SN6PR02MB45766EC9C9CB0A5291932AD5C2A59@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220524094745.287002-1-nava.manne@xilinx.com>
 <20220524094745.287002-4-nava.manne@xilinx.com>
 <20220528152127.GA181580@yilunxu-OptiPlex-7050>
In-Reply-To: <20220528152127.GA181580@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: effdb3df-fba4-4b1c-dcb9-08da48486ded
x-ms-traffictypediagnostic: BN6PR02MB2611:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN6PR02MB2611CC2F573C423049D559BAC2A59@BN6PR02MB2611.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9t0BXAnEB1V5SD2/V2RvkTHQ6DoDPIpQC8FQkaHt5BaTAtcQmbaKf496OtqWQDYmMZzX4R5u7475TIKfzcg1NmuUhcQnR9JQTHat4jxbSKiE2Vw1uv+1Y646T3gsQQLDq1vSGkB7/U5cWPaZf7GOq8kEKCMrPzHT/ZZG2sX3XIqiE00PuSk5F1OuzYehHs0CQUC9OgBr/7cPaPCJxybP5TroLugIS34q5KtIY9NH6G/pdIbMmyQn2radgYHk03TRjSYcxoYLZTy6GqmTZhP3LoXhejF4OLrVeXHxMNOQspy5lllGxEInIL0BKi5tKjOin89S4ZgUxn+gQTxnR+86BM9bz8nZu37Yh4ie9DT9q9qKpUkNYAjy3HuO7krO0QwzU+v79rgtu0237BMMjcCov4jCm5dIFY9esolfCMnMOBrJ+ZP7UQ0WtOIxTheKlzsedkXWo+p0JswVvdVZOFsZ424s4+6rN6GShF/6PjcQISfvvIsUtI4qcVtaid7r2wu5t6zt9S9RvK95D1kMF/1Vmu8LmLlzrVBzIih5aVgGAQY+jbqpEBJkhKp6JOqaLTbsM+KxenpmNxvUDu/F+QZHWMM4rSxzk/lvH32TaNQjF+4kb866qxY0fFu8gYTRzwqyR4Ufrs8MPZ7x7DIx6qAhHI2/uhDazhAU+56hYhQpl+UIHjQif1J2/doI3iVpGpjzjMPElBaz5+d4IxHbf3dcoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(2906002)(26005)(9686003)(6506007)(71200400001)(55236004)(7696005)(508600001)(86362001)(33656002)(54906003)(316002)(38100700002)(6916009)(38070700005)(52536014)(66446008)(66946007)(66476007)(66556008)(55016003)(76116006)(122000001)(8936002)(186003)(83380400001)(107886003)(8676002)(5660300002)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/RTh9WBVLhiYtej0JdzbPbFZGN/314rc3yy1Y9n93c77Cf4Of+u+KJIkWDcC?=
 =?us-ascii?Q?ujUYEEE45GdsfYImGgeBuL7HR5kjWYckSQwIGKrK8FFtl6Obf5J9mJj5oAcf?=
 =?us-ascii?Q?rpymXp3KT+j1gfy5j3U21XHlZFA2mXw6bk4F/siqKuF3l51ZkFYhjm0vuoA/?=
 =?us-ascii?Q?nafD7Zj9nLP/lJ9BEiEY9jMfQ9KlJi8GRtLFyYrSydP5fn4c3nYnhtaYit7o?=
 =?us-ascii?Q?atTkLUtgZFkdgW6EJSGAC6g09wZGnn8NYrBfM2LDgSzFYYOLH47ihTdNmnBM?=
 =?us-ascii?Q?5FPeqZFoAcbSiw4WjEuaGVwwVp872m0GdO3BMYGmTQTmBdobRjpt4wUXXt07?=
 =?us-ascii?Q?qhTJvfb5wprKzDqdQtxJVwuuX3qJBMNI6j33wiem4OhfxTNlq4jYUvmmJB5u?=
 =?us-ascii?Q?Q8DXAHvIjdbgS/EnxUOl5TTkqB5neZ0qR858NHZtbV+24hin3I++dNCPmlb2?=
 =?us-ascii?Q?OvLtKhhFusUR3lpMOa7PRRK50Bb6HhlUE6c9ODPQX6XkcbWg1z8NOPGxhsjX?=
 =?us-ascii?Q?auT78u+d6ufelxCBDPB8lAWMkrWIsbqfL8cEviCiMwBXjSHIZ1h+DIM4PtYK?=
 =?us-ascii?Q?Xvg4k8xn0Mga27w+1LYs8sLYROacEIYsmDmcXGW3foIZjcK+lCqajGq/01TA?=
 =?us-ascii?Q?+g9SHM28hO8hfKUCZeuRCAXRxrv19TZF2SiNw2OqYqv39tTT7GYzgwv+AZvO?=
 =?us-ascii?Q?Owzm6iVmN/rY7YsJW58jS6yO1FCwjk0Qpq+7ykWEgFTsHWyR4gHM86HJ76+q?=
 =?us-ascii?Q?bg0c76+EHxmFkM30U6MNNtNs/bVbiz6K97/y8dULdR0Rbc03LgWZZYQ7YRs+?=
 =?us-ascii?Q?5FDaL6NxPdxS3OA+4RGOqnyPaYSzZK/HjdZujTPANrzkciGcr/DwsLNTMJd1?=
 =?us-ascii?Q?5fjWKQtTfvKYhrMA82h41xIeBl4JKfJ1o1ZhckpBxnzCQDDcihe2BrXs51C5?=
 =?us-ascii?Q?O2jA7BC4gpbkLPkVX/bvFJsgHxiAAeFB4f7hOH2HUX0VQvWj0jg7/ntJOkUi?=
 =?us-ascii?Q?ajtDO58VoqpMHtKc7nO63ybJr4yQZBv2YcnqH6B7d7NZWiKIXwmDZcA3CLs8?=
 =?us-ascii?Q?yXLFTGn8cMuSdlXlbDXjToyM5INGmjc0NHzyIpS83cfZlKtx5S+Ugaj8nCKO?=
 =?us-ascii?Q?uQ6X6gYvGR1i2UkrJQpD2X8b7JNAGiqi8X/qzpUK60Zg/L+O0XJXsKcBJqqI?=
 =?us-ascii?Q?COnKxDUOHGjOJwCGKmysjEvBMv29wLWH3RiqPAOZBYpjgDdrKivyrspqgB8c?=
 =?us-ascii?Q?XtGVqFXeN4UEOKel7NR91wV3/qdxuM6q8XeBENYvfLFXGpkFeO9ioS4rtR0p?=
 =?us-ascii?Q?B3koL0XykZiSrnTZ0RA1/FevExyyBZnioame7uPCTUghoonUcur4X2lYTMBf?=
 =?us-ascii?Q?b99xql699uPyEVs/+6Cr0SZwWTcKLQAv/6I322H4EAakozTi45YxKsChKlGu?=
 =?us-ascii?Q?zY0qiqCNd64DD+UNxEj41RNQwwMrqU6bCq9spZZ+spcXJiiUcT3KnGG4mXUA?=
 =?us-ascii?Q?fyL8r3wm/mB/KOW/GM1R6MpOu0GaJZ0evrGr8hN4LHPdxTUxZtlBTfB4Ei60?=
 =?us-ascii?Q?dSJs4QWEcPO25b5obe4exPcGbB7FTZ82OYcqcCs1YEzsDuXo0GUI2yoE4gQI?=
 =?us-ascii?Q?VfPhCYPRrM3SjJ9e56La1PjS0sHbkrOKR0OjgZzB3W8whshohJdTsRhwOSte?=
 =?us-ascii?Q?UeT3RssJ11fg/HuSvjrCQQKY3S3WaY+mvWa1Dnq2mKukobDl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effdb3df-fba4-4b1c-dcb9-08da48486ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 05:41:54.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k48rOkMMLDCUKPrAleAC4QMMPqIdWDqw8C6D334Wpy18AQUkNPkl7/4Fjag0158IpRnGWVNllNZbQUoAc/YsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2611
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

	Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Saturday, May 28, 2022 8:51 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; mdf@kernel.org;
> hao.wu@intel.com; trix@redhat.com; gregkh@linuxfoundation.org; Ronak
> Jain <ronakj@xilinx.com>; Abhyuday Godhasara <agodhasa@xilinx.com>;
> Rajan Vaja <rajanv@xlnx.xilinx.com>; Sai Krishna Potthuri
> <lakshmis@xilinx.com>; Piyush Mehta <piyushm@xilinx.com>; Harsha
> Harsha <harshah@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-fpga@vger.kernel.org; git <git@xilinx.com>
> Subject: Re: [PATCH 3/3] fpga: zynqmp-fpga: Adds status interface
>=20
> On Tue, May 24, 2022 at 03:17:45PM +0530, Nava kishore Manne wrote:
> > Adds status interface for zynqmp-fpga, It's a read only interface
> > which allows the user to get the PL status.
> >
> > Usage:
> > To read the PL configuration status
> >         cat /sys/class/fpga_manager/<fpga>/status
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/zynqmp-fpga.c | 52
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index c60f20949c47..07c7b7326726 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -14,6 +14,19 @@
> >
> >  /* Constant Definitions */
> >  #define IXR_FPGA_DONE_MASK	BIT(3)
> > +#define READ_DMA_SIZE		256U
> > +
> > +/* Error Register */
> > +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
> > +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
> > +
> > +/* Signal Status Register. For details refer ug570 */
> > +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
> > +#define IXR_FPGA_GST_CFG_B		BIT(5)
> > +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
> > +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
> > +
> > +#define IXR_FPGA_CONFIG_STAT_OFFSET	7U
> >
> >  /**
> >   * struct zynqmp_fpga_priv - Private data structure @@ -77,8 +90,47
> > @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct
> fpga_manager *mgr)
> >  	return FPGA_MGR_STATE_UNKNOWN;
> >  }
> >
> > +static u64 zynqmp_fpga_ops_status(struct fpga_manager *mgr) {
> > +	unsigned int *buf, reg_val;
> > +	dma_addr_t dma_addr;
> > +	u64 status =3D 0;
> > +	int ret;
> > +
> > +	buf =3D dma_alloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
> > +				 &dma_addr, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	ret =3D zynqmp_pm_fpga_read(IXR_FPGA_CONFIG_STAT_OFFSET,
> dma_addr,
> > +				  PM_FPGA_READ_CONFIG_REG, &reg_val);
> > +	if (ret) {
> > +		status =3D FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
> > +		goto free_dmabuf;
> > +	}
> > +
> > +	if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> > +		status |=3D FPGA_MGR_STATUS_CRC_ERR;
> > +	if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> > +		status |=3D FPGA_MGR_STATUS_SECURITY_ERR;
> > +	if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> > +		status |=3D FPGA_MGR_STATUS_DEVICE_INIT_ERR;
> > +	if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> > +		status |=3D FPGA_MGR_STATUS_SIGNAL_ERR;
> > +	if (!(reg_val & IXR_FPGA_GST_CFG_B))
> > +		status |=3D FPGA_MGR_STATUS_HIGH_Z_STATE_ERR;
> > +	if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> > +		status |=3D FPGA_MGR_STATUS_EOS_ERR;
>=20
> I have concern about the status interface. Different vendors have differn=
t
> error sets defined by Hardwares. If we always define the new bits when we
> cannot find an exact 1:1 mapping. A 64 bits would soon be used out. Also =
it's
> hard to understand the mixture of different error sets.
>=20
> I'd rather suggest that each driver define its own error reading interfac=
e.
>=20
I agree Ideally, the core file should contain only the generic stuff and ea=
ch vendor has its own set of status messages.
So status related messages should be part of the vendor specific files(not =
in the core files).
Will update the zynqmp_fpga_ops_status() API to popup the status messages (=
for ZynqMP FPGA related status messages).

Regards,
Navakishore.

