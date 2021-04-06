Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FEB354E42
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 10:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhDFIHn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbhDFIHm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Apr 2021 04:07:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A588C06175F
        for <linux-fpga@vger.kernel.org>; Tue,  6 Apr 2021 01:07:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b9so5268829wrs.1
        for <linux-fpga@vger.kernel.org>; Tue, 06 Apr 2021 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6gLMcm8AUrA0Q2uwmWu7QTYhzmtluEu0Sc3ZsLKSdUU=;
        b=oR8K/ur+8w492vaSpjRXojAbyedPYr/+Y+OkD4K+li2Sji5cjLcw7WbP0jjAVrp6vn
         p4joMWEYt8aRs9ury1VAvDMaiAB54evkNeY/qtBtEqeZlP+aF3A33RIJARzGOGwbwSy4
         OjBK94BR3TflT9RDcGWMhSExiCk/EcVL0jCOM7PZ+3WxblPnKXibq+9s7Jsa5m6VH1lR
         F6z2vgOsiUQep70gX0sgSoSHv02qNiyWCnfcT9B/32MEjFrF1dSxYsQCWRDMq3xdZUZE
         Lak7TQKahYdue+11eBqP8v7NaqRhGU+SqyvAXeQZ8glOJrgx9gkW3zrssz/D/qoRtFZK
         CZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6gLMcm8AUrA0Q2uwmWu7QTYhzmtluEu0Sc3ZsLKSdUU=;
        b=Qu1yT2ioEH/3L+IvHhCBj5YH8rT67gLHQv6aCobB7Mbk6kUrBc1OXgVjtaT189iZBd
         s8URLZnhLXX3zkR70QCHcbt8xM7G8nJn+HSD2TdtXoisAMs1d3POpE+UznKuii6/60NU
         7P0N+nrgStQeaEcCHMt02GXauVaD67ePH1756pBsdCVBMCDsToZTkyt2tDu+9l71Ya11
         Fof6ojfVr1fDGK7OCVP4lxPnRasjJBB6LYaljwIye8nw6qxgZrF8RLnFmnhRozWMhjsC
         dkmY8mqv7bYiQU3eaV0uADI+eQT/D7Vb9D7w6xwAVB75pN6LDU3wH2m95F1Tr9ao1p/e
         OAFA==
X-Gm-Message-State: AOAM531S9LGdRe/7tYV3reqaGTeRK3B+blaxuINklZIoJUtChrPJYmmc
        OUAE+ZKQ7ngQzcSN9Gg1bCUe8w==
X-Google-Smtp-Source: ABdhPJwliCeV08eP6FOrU6E+gj/DTQLZ2EMzOu5/Q3pVo0qMOBjAHK08jnu7YlYh6db3AmtFVnZ1aQ==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr4542186wru.380.1617696450874;
        Tue, 06 Apr 2021 01:07:30 -0700 (PDT)
Received: from dell ([91.110.221.175])
        by smtp.gmail.com with ESMTPSA id u63sm1904343wmg.24.2021.04.06.01.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:07:30 -0700 (PDT)
Date:   Tue, 6 Apr 2021 09:07:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        russell.h.weight@linux.intel.com
Subject: Re: [PATCH 3/3] hwmon: intel-m10-bmc-hwmon: add sensor support of
 Intel D5005 card
Message-ID: <20210406080728.GO2916463@dell>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-4-matthew.gerlach@linux.intel.com>
 <2bafe404-c708-a1eb-6584-2345225282dc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bafe404-c708-a1eb-6584-2345225282dc@roeck-us.net>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 05 Apr 2021, Guenter Roeck wrote:

> On 4/5/21 4:53 PM, matthew.gerlach@linux.intel.com wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > Like the Intel N3000 card, the Intel D5005 has a MAX10 based
> > BMC.  This commit adds support for the D5005 sensors that are
> > monitored by the MAX10 BMC.
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@linux.intel.com>
> > ---
> >  drivers/hwmon/intel-m10-bmc-hwmon.c | 122 ++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/intel-m10-bmc.c         |  10 +++
> >  2 files changed, 132 insertions(+)
> > 
> > diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> > index 17d5e6b..bd7ed2e 100644
> > --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> > +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> > @@ -99,6 +99,50 @@ struct m10bmc_hwmon {
> >  	NULL
> >  };
> >  
> > +static const struct m10bmc_sdata d5005bmc_temp_tbl[] = {
> > +	{ 0x100, 0x104, 0x108, 0x10c, 0x0, 500, "Board Inlet Air Temperature" },
> > +	{ 0x110, 0x114, 0x118, 0x0, 0x0, 500, "FPGA Core Temperature" },
> > +	{ 0x11c, 0x120, 0x124, 0x128, 0x0, 500, "Board Exhaust Air Temperature" },
> > +	{ 0x12c, 0x130, 0x134, 0x0, 0x0, 500, "FPGA Transceiver Temperature" },
> > +	{ 0x138, 0x13c, 0x140, 0x144, 0x0, 500, "RDIMM0 Temperature" },
> > +	{ 0x148, 0x14c, 0x150, 0x154, 0x0, 500, "RDIMM1 Temperature" },
> > +	{ 0x158, 0x15c, 0x160, 0x164, 0x0, 500, "RDIMM2 Temperature" },
> > +	{ 0x168, 0x16c, 0x170, 0x174, 0x0, 500, "RDIMM3 Temperature" },
> > +	{ 0x178, 0x17c, 0x180, 0x0, 0x0, 500, "QSFP0 Temperature" },
> > +	{ 0x188, 0x18c, 0x190, 0x0, 0x0, 500, "QSFP1 Temperature" },
> > +	{ 0x1a0, 0x1a4, 0x1a8, 0x0, 0x0, 500, "3.3v Temperature" },
> > +	{ 0x1bc, 0x1c0, 0x1c4, 0x0, 0x0, 500, "VCCERAM Temperature" },
> > +	{ 0x1d8, 0x1dc, 0x1e0, 0x0, 0x0, 500, "VCCR Temperature" },
> > +	{ 0x1f4, 0x1f8, 0x1fc, 0x0, 0x0, 500, "VCCT Temperature" },
> > +	{ 0x210, 0x214, 0x218, 0x0, 0x0, 500, "1.8v Temperature" },
> > +	{ 0x22c, 0x230, 0x234, 0x0, 0x0, 500, "12v Backplane Temperature" },
> > +	{ 0x248, 0x24c, 0x250, 0x0, 0x0, 500, "12v AUX Temperature" },
> > +};
> > +
> > +static const struct m10bmc_sdata d5005bmc_in_tbl[] = {
> > +	{ 0x184, 0x0, 0x0, 0x0, 0x0, 1, "QSFP0 Supply Voltage" },
> > +	{ 0x194, 0x0, 0x0, 0x0, 0x0, 1, "QSFP1 Supply Voltage" },
> > +	{ 0x198, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage" },
> > +	{ 0x1ac, 0x1b0, 0x1b4, 0x0, 0x0, 1, "3.3v Voltage" },
> > +	{ 0x1c8, 0x1cc, 0x1d0, 0x0, 0x0, 1, "VCCERAM Voltage" },
> > +	{ 0x1e4, 0x1e8, 0x1ec, 0x0, 0x0, 1, "VCCR Voltage" },
> > +	{ 0x200, 0x204, 0x208, 0x0, 0x0, 1, "VCCT Voltage" },
> > +	{ 0x21c, 0x220, 0x224, 0x0, 0x0, 1, "1.8v Voltage" },
> > +	{ 0x238, 0x0, 0x0, 0x0, 0x23c, 1, "12v Backplane Voltage" },
> > +	{ 0x254, 0x0, 0x0, 0x0, 0x258, 1, "12v AUX Voltage" },
> > +};
> > +
> > +static const struct m10bmc_sdata d5005bmc_curr_tbl[] = {
> > +	{ 0x19c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Current" },
> > +	{ 0x1b8, 0x0, 0x0, 0x0, 0x0, 1, "3.3v Current" },
> > +	{ 0x1d4, 0x0, 0x0, 0x0, 0x0, 1, "VCCERAM Current" },
> > +	{ 0x1f0, 0x0, 0x0, 0x0, 0x0, 1, "VCCR Current" },
> > +	{ 0x20c, 0x0, 0x0, 0x0, 0x0, 1, "VCCT Current" },
> > +	{ 0x228, 0x0, 0x0, 0x0, 0x0, 1, "1.8v Current" },
> > +	{ 0x240, 0x244, 0x0, 0x0, 0x0, 1, "12v Backplane Current" },
> > +	{ 0x25c, 0x260, 0x0, 0x0, 0x0, 1, "12v AUX Current" },
> > +};
> > +
> >  static const struct m10bmc_hwmon_board_data n3000bmc_hwmon_bdata = {
> >  	.tables = {
> >  		[hwmon_temp] = n3000bmc_temp_tbl,
> > @@ -110,6 +154,80 @@ struct m10bmc_hwmon {
> >  	.hinfo = n3000bmc_hinfo,
> >  };
> >  
> > +static const struct hwmon_channel_info *d5005bmc_hinfo[] = {
> > +	HWMON_CHANNEL_INFO(temp,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> > +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> > +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> > +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> > +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> > +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> > +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> > +			   HWMON_T_LABEL),
> > +	HWMON_CHANNEL_INFO(in,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> > +			   HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> > +			   HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> > +			   HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> > +			   HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> > +			   HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_LABEL),
> > +	HWMON_CHANNEL_INFO(curr,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL,
> > +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_LABEL,
> > +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_LABEL),
> > +	NULL
> > +};
> > +
> > +static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
> > +	.tables = {
> > +		[hwmon_temp] = d5005bmc_temp_tbl,
> > +		[hwmon_in] = d5005bmc_in_tbl,
> > +		[hwmon_curr] = d5005bmc_curr_tbl,
> > +	},
> > +
> > +	.hinfo = d5005bmc_hinfo,
> > +};
> > +
> >  static umode_t
> >  m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> >  			u32 attr, int channel)
> > @@ -316,6 +434,10 @@ static int m10bmc_hwmon_probe(struct platform_device *pdev)
> >  		.name = "n3000bmc-hwmon",
> >  		.driver_data = (unsigned long)&n3000bmc_hwmon_bdata,
> >  	},
> > +	{
> > +		.name = "d5005bmc-hwmon",
> > +		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
> > +	},
> >  	{ }
> >  };
> >  
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> 
> It may be better to split this patch into two parts to simplify
> its review and scope of responsibility.

No need.

Not withstanding significant changes:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
