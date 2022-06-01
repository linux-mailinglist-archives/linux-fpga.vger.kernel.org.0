Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3F539F77
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Jun 2022 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbiFAI1f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 1 Jun 2022 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350621AbiFAI1e (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 1 Jun 2022 04:27:34 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928CDF83;
        Wed,  1 Jun 2022 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=50cD+iAXnAyDsdbwmGD7FRwmVdHsOBuhM7VzSWfWv/c=;
        b=mONxoWLc0dnmRAC/rqdhQApB6FiuPqzDTv7s+fmE77nRRrzq5mjh/7yeYYU5qufEdKuv0uj1os9Mu
         detewmiW10ioee8RMehatZb0C1rur0SMmczGS+ONVyTk+YJZyU0Np6fJIjCs/sGoESb9tAve9zvhC0
         gQ2lrGCEgLe9balM9LBOXD+qIYaUx7L8Hl8ZrtSttZmTHjxowMcc0pZeHwUS2aS9/ZHqNSZyyBIr/J
         mBMq7G0i+G7q4EKSnnfXLsuXoxiIHsyokZiHQqf+HOOqy2r8WJpgBsBy7vm8hIlECvwpQ1uRMeKpZ3
         Orv+Vu2k4PSwOdVUt5Pejzu4w1JsLSQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.020715)], BW: [Enabled, t: (0.000029,0.000001)], RTDA: [Enabled, t: (1.097317), Hit: No, Details: v3.19.0; Id: 15.52k2o7.1g4f60dc0.81025], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 1 Jun 2022 11:27:06 +0300
Date:   Wed, 1 Jun 2022 11:04:55 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor.Dooley@microchip.com
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v14 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220601080455.hfi34aknvasbxz2q@x260>
References: <20220531192344.23038-1-i.bornyakov@metrotek.ru>
 <20220531192344.23038-3-i.bornyakov@metrotek.ru>
 <7a350b92-d6a6-c0e1-95f7-ff711699f850@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a350b92-d6a6-c0e1-95f7-ff711699f850@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 01, 2022 at 07:49:48AM +0000, Conor.Dooley@microchip.com wrote:
> On 31/05/2022 20:23, Ivan Bornyakov wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Add support to the FPGA manager for programming Microchip Polarfire
> > FPGAs over slave SPI interface with .dat formatted bitsream image.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> 
> Hey Ivan,
> Could've kept at least the R-b tag from v13, but either way:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> I did have another look at Yiluns two questions.
> The reason for the double status read effectively boils down
> to the system controller potentially not having had enough
> time to process the previous command/frame and update its
> status yet.
> 
> And see below about the memcpy()...
> 
> > ---
> >   drivers/fpga/Kconfig         |   9 +
> >   drivers/fpga/Makefile        |   1 +
> >   drivers/fpga/microchip-spi.c | 384 +++++++++++++++++++++++++++++++++++
> >   3 files changed, 394 insertions(+)
> >   create mode 100644 drivers/fpga/microchip-spi.c
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 26025dbab353..75806ef5c9ea 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -248,4 +248,13 @@ config FPGA_MGR_VERSAL_FPGA
> >            configure the programmable logic(PL).
> > 
> >            To compile this as a module, choose M here.
> > +
> > +config FPGA_MGR_MICROCHIP_SPI
> > +       tristate "Microchip Polarfire SPI FPGA manager"
> > +       depends on SPI
> > +       help
> > +         FPGA manager driver support for Microchip Polarfire FPGAs
> > +         programming over slave SPI interface with .dat formatted
> > +         bitstream image.
> > +
> >   endif # FPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index e32bfa90f968..5425a15892df 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -19,6 +19,7 @@ obj-$(CONFIG_FPGA_MGR_XILINX_SPI)     += xilinx-spi.o
> >   obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> >   obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     += zynqmp-fpga.o
> >   obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)     += versal-fpga.o
> > +obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)   += microchip-spi.o
> >   obj-$(CONFIG_ALTERA_PR_IP_CORE)                += altera-pr-ip-core.o
> >   obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)   += altera-pr-ip-core-plat.o
> > 
> > diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> > new file mode 100644
> > index 000000000000..413e5c364f68
> ---8<---
> > +
> > +static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
> > +{
> > +       u8 tmp_buf[MPF_SPI_FRAME_SIZE + 1] = { MPF_SPI_FRAME, };
> > +       struct mpf_priv *priv = mgr->priv;
> > +       struct device *dev = &mgr->dev;
> > +       struct spi_device *spi;
> > +       int ret, i;
> > +
> > +       if (count % MPF_SPI_FRAME_SIZE) {
> > +               dev_err(dev, "Bitstream size is not a multiple of %d\n",
> > +                       MPF_SPI_FRAME_SIZE);
> > +               return -EINVAL;
> > +       }
> > +
> > +       spi = priv->spi;
> > +
> > +       for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
> > +               memcpy(tmp_buf + 1, buf + i * MPF_SPI_FRAME_SIZE,
> > +                      MPF_SPI_FRAME_SIZE);
> > +
> > +               ret = mpf_spi_write(spi, tmp_buf, sizeof(tmp_buf));
> > +               if (ret) {
> > +                       dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
> > +                               i, count / MPF_SPI_FRAME_SIZE);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> 
> I was able to program with the following diff, which is effectively
> the same as the one you sent (which also worked for me):
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 413e5c364f68..fa6220e8056a 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -268,7 +268,8 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
>   
>   static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
>   {
> -       u8 tmp_buf[MPF_SPI_FRAME_SIZE + 1] = { MPF_SPI_FRAME, };
> +       u8 spi_frame_command = MPF_SPI_FRAME;
> +       struct spi_transfer xfers[2] = { 0 };
>          struct mpf_priv *priv = mgr->priv;
>          struct device *dev = &mgr->dev;
>          struct spi_device *spi;
> @@ -282,11 +283,16 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
>   
>          spi = priv->spi;
>   
> +       xfers[0].tx_buf = &spi_frame_command;
> +       xfers[0].len = 1;
> +
>          for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
> -               memcpy(tmp_buf + 1, buf + i * MPF_SPI_FRAME_SIZE,
> -                      MPF_SPI_FRAME_SIZE);
> +               xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
> +               xfers[1].len = MPF_SPI_FRAME_SIZE;
>   
> -               ret = mpf_spi_write(spi, tmp_buf, sizeof(tmp_buf));
> +               ret = mpf_poll_status(spi, 0);
> +               if (ret >= 0)
> +                       ret = spi_sync_transfer(spi, xfers, 2);
>                  if (ret) {
>                          dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
>                                  i, count / MPF_SPI_FRAME_SIZE);
> 
> Have you been able to look at a waveform of programming like this
> on your hardware? Off the top of my head, I was wondering if your
> spi controller releases CS between every xfer?
> Mine is perfectly happy not to release it - which is why I noticed
> the extra cs_change in mpf_read_status().
> 
> Thanks,
> Conor.
> 

Thanks for the hint. I'll ask our HW folks if it's possible.

