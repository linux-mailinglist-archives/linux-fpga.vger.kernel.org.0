Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70955549F6
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jun 2022 14:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiFVMRG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Jun 2022 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiFVMQ4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Jun 2022 08:16:56 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF88340C6;
        Wed, 22 Jun 2022 05:16:53 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5FCDB10000A;
        Wed, 22 Jun 2022 12:16:47 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1o3zHr-0099t6-5Y; Wed, 22 Jun 2022 14:16:47 +0200
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
Subject: Re: [PATCH v2 3/3] fpga: zynqmp-fpga: Adds status interface
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
        <20220621092833.1057408-4-nava.manne@xilinx.com>
Date:   Wed, 22 Jun 2022 14:16:47 +0200
In-Reply-To: <20220621092833.1057408-4-nava.manne@xilinx.com> (Nava kishore
        Manne's message of "Tue, 21 Jun 2022 14:58:33 +0530")
Message-ID: <87edzg51w0.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

>>>>> "Nava" == Nava kishore Manne <nava.manne@xilinx.com> writes:

 > Adds status interface for zynqmp-fpga, It's a read only
 > interface which allows the user to get the PL status.

 > Usage:
 > To read the PL configuration status
 >         cat /sys/class/fpga_manager/<fpga>/status

 > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
 > ---
 > Changes for v2:
 >               - Updated status messages handling logic as suggested by Xu Yilun.

 >  drivers/fpga/zynqmp-fpga.c | 53 ++++++++++++++++++++++++++++++++++++++
 >  1 file changed, 53 insertions(+)

 > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
 > index c60f20949c47..e194bba91d3f 100644
 > --- a/drivers/fpga/zynqmp-fpga.c
 > +++ b/drivers/fpga/zynqmp-fpga.c
 > @@ -14,6 +14,19 @@
 
 >  /* Constant Definitions */
 >  #define IXR_FPGA_DONE_MASK	BIT(3)
 > +#define READ_DMA_SIZE		256U
 > +
 > +/* Error Register */
 > +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
 > +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
 > +
 > +/* Signal Status Register. For details refer ug570 */
 > +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
 > +#define IXR_FPGA_GST_CFG_B		BIT(5)
 > +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
 > +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
 > +
 > +#define IXR_FPGA_CONFIG_STAT_OFFSET	7U
 
 >  /**
 >   * struct zynqmp_fpga_priv - Private data structure
 > @@ -77,8 +90,48 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 >  	return FPGA_MGR_STATE_UNKNOWN;
 >  }
 
 > +static ssize_t zynqmp_fpga_ops_status(struct fpga_manager *mgr, char *buf)
 > +{
 > +	unsigned int *kbuf, reg_val;
 > +	dma_addr_t dma_addr;
 > +	ssize_t len = 0;
 > +	int ret;
 > +
 > +	kbuf = dma_alloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
 > +				  &dma_addr, GFP_KERNEL);
 > +	if (!kbuf)
 > +		return -ENOMEM;

What is kbuf used for? You don't seem to ever access it?

-- 
Bye, Peter Korsgaard
