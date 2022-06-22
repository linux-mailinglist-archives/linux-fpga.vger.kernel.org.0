Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D25549DA
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jun 2022 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357654AbiFVMP2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Jun 2022 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358158AbiFVMOP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Jun 2022 08:14:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A4118B20;
        Wed, 22 Jun 2022 05:14:13 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 157A0C0004;
        Wed, 22 Jun 2022 12:14:07 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1o3zFG-0099lr-Vg; Wed, 22 Jun 2022 14:14:06 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     <michal.simek@xilinx.com>, <hao.wu@intel.com>, <trix@redhat.com>,
        <mdf@kernel.org>, <yilun.xu@intel.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <piyush.mehta@xilinx.com>, <harsha.harsha@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: Re: [PATCH v2 2/3] firmware: xilinx: Add pm api function for PL
 readback
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
        <20220621092833.1057408-3-nava.manne@xilinx.com>
Date:   Wed, 22 Jun 2022 14:14:06 +0200
In-Reply-To: <20220621092833.1057408-3-nava.manne@xilinx.com> (Nava kishore
        Manne's message of "Tue, 21 Jun 2022 14:58:32 +0530")
Message-ID: <87ilos520h.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

>>>>> "Nava" == Nava kishore Manne <nava.manne@xilinx.com> writes:

 > Adds PM API for performing PL configuration readback.
 > It provides an interface to the pmufw to readback the
 > FPGA configuration registers as well as configuration
 > data.

 > For more detailed info related to the configuration
 > registers and configuration data refer ug570.

 > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
 > ---
 > Changes for v2:
 >               - None.

 >  drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++++++++++++
 >  include/linux/firmware/xlnx-zynqmp.h | 14 ++++++++++++
 >  2 files changed, 47 insertions(+)

 > diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
 > index 7977a494a651..40b99299b662 100644
 > --- a/drivers/firmware/xilinx/zynqmp.c
 > +++ b/drivers/firmware/xilinx/zynqmp.c
 > @@ -927,6 +927,39 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 >  }
 >  EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
 
 > +/**
 > + * zynqmp_pm_fpga_read - Perform the fpga configuration readback
 > + * @reg_numframes: Configuration register offset (or) Number of frames to read

An offset OR a length? That sounds odd.


 > + * @phys_address: Physical Address of the buffer
 > + * @readback_type: Type of fpga readback operation
 > + *                 0 - FPGA configuration register readback
 > + *                 1 - FPGA configuration data readback

readback_type is a boolean, so how about calling it `bool data` or
something like that?


 > + * @value: Value to read

what is the relation between phys_address and this value output
argument?

 > + *
 > + * This function provides access to xilfpga library to perform
 > + * fpga configuration readback.
 > + *
 > + * Return:	Returns status, either success or error+reason
 > + */
 > +int zynqmp_pm_fpga_read(const u32 reg_numframes, const phys_addr_t phys_address,
 > +			bool readback_type, u32 *value)
 > +{
 > +	u32 ret_payload[PAYLOAD_ARG_CNT];
 > +	int ret;
 > +
 > +	if (!value)
 > +		return -EINVAL;
 > +
 > +	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, reg_numframes,
 > +				  lower_32_bits(phys_address),
 > +				  upper_32_bits(phys_address), readback_type,

You are adding PM_FPGA_READ_CONFIG_ defines, so how about using them,
E.G.

data ? PM_FPGA_READ_CONFIG_DATA : PM_FPGA_READ_CONFIG_REG

-- 
Bye, Peter Korsgaard
