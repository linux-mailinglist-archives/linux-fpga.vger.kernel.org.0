Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50377394897
	for <lists+linux-fpga@lfdr.de>; Sat, 29 May 2021 00:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhE1WQf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 May 2021 18:16:35 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:34707 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhE1WQe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 May 2021 18:16:34 -0400
Received: by mail-pj1-f46.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso7921027pjx.1;
        Fri, 28 May 2021 15:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lN/9YS4XrWsb7/Yja26anKu9iyUlLlsoGJNs/MgSvfo=;
        b=Rysd7Fy8PTU5yGH4ANIzFcAHg3GdedSI7aOC+m0pHMbCAQ28WJboff0Wcfmh7DazV0
         wapyt2eHaGaPW5fzAE7m96JYs3clKVh/U8Tn4P/DMeLb//yIoLXw2yJYfV+AJLwmA8tT
         MlkG3UvYU+6A7h52bpMU8BS0f2YhieZt/K7CftOxMZgCs/+XTmlKizVIKjcWcAUeWKS/
         qwZM7lhKaKe7s2f+bxlg8V1LDyBlz/cYLrWgZhr3vDhm0L0MawntuYyGCTAEd0q5toCd
         TagU9t/qp2vvSezrkNoAzWOtI7dz+aNhGWMpRKMDdGZkYuy0v7D6jZpPIOmPPs8rlTJQ
         YV0A==
X-Gm-Message-State: AOAM531QoDanpU+M54H/oxhhsVJWCfYrR5uaHTCLiixWbSKL8nRLGB1Z
        k+FETUJ/MwogDkmZnb569+Y=
X-Google-Smtp-Source: ABdhPJwW1o9TggoqfgoKT3cVH5LlPlXNbR1dGE58xAktu5CTQ4UiNCgbg4paDqbV9QSAcePgtlmJpw==
X-Received: by 2002:a17:90a:390a:: with SMTP id y10mr6611249pjb.9.1622240098246;
        Fri, 28 May 2021 15:14:58 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id mv15sm4955389pjb.25.2021.05.28.15.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 15:14:57 -0700 (PDT)
Date:   Fri, 28 May 2021 15:14:56 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fpga: fix spelling mistakes
Message-ID: <YLFrYCKqF0394iBw@epycbox.lan>
References: <20210519163056.1966690-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519163056.1966690-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 19, 2021 at 09:30:56AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Run the fpga subsystem through aspell.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  Documentation/fpga/dfl.rst    | 4 ++--
>  drivers/fpga/altera-cvp.c     | 2 +-
>  drivers/fpga/dfl-fme-pr.c     | 2 +-
>  drivers/fpga/dfl-n3000-nios.c | 2 +-
>  drivers/fpga/dfl.h            | 2 +-
>  drivers/fpga/fpga-bridge.c    | 4 ++--
>  drivers/fpga/zynq-fpga.c      | 6 +++---
>  include/linux/fpga/fpga-mgr.h | 2 +-
>  8 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index f3a1223f2517e..ccc33f199df2a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -10,7 +10,7 @@ Authors:
>  - Xu Yilun <yilun.xu@intel.com>
>  
>  The Device Feature List (DFL) FPGA framework (and drivers according to
> -this framework) hides the very details of low layer hardwares and provides
> +this framework) hides the very details of low layer hardware and provides
>  unified interfaces to userspace. Applications could use these interfaces to
>  configure, enumerate, open and access FPGA accelerators on platforms which
>  implement the DFL in the device memory. Besides this, the DFL framework
> @@ -205,7 +205,7 @@ given Device Feature Lists and create platform devices for feature devices
>  also abstracts operations for the private features and exposes common ops to
>  feature device drivers.
>  
> -The FPGA DFL Device could be different hardwares, e.g. PCIe device, platform
> +The FPGA DFL Device could be different hardware, e.g. PCIe device, platform
>  device and etc. Its driver module is always loaded first once the device is
>  created by the system. This driver plays an infrastructural role in the
>  driver architecture. It locates the DFLs in the device memory, handles them
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4e0edb60bfba6..ccf4546eff297 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -346,7 +346,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	}
>  
>  	if (val & VSE_CVP_STATUS_CFG_RDY) {
> -		dev_warn(&mgr->dev, "CvP already started, teardown first\n");
> +		dev_warn(&mgr->dev, "CvP already started, tear down first\n");
>  		ret = altera_cvp_teardown(mgr, info);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index 1194c0e850e07..d61ce9a188792 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -148,7 +148,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  
>  	/*
>  	 * it allows userspace to reset the PR region's logic by disabling and
> -	 * reenabling the bridge to clear things out between accleration runs.
> +	 * reenabling the bridge to clear things out between acceleration runs.
>  	 * so no need to hold the bridges after partial reconfiguration.
>  	 */
>  	if (region->get_bridges)
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> index 7a95366f6516f..9ddf1d1d392f3 100644
> --- a/drivers/fpga/dfl-n3000-nios.c
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -461,7 +461,7 @@ static int n3000_nios_poll_stat_timeout(void __iomem *base, u64 *v)
>  	 * We don't use the time based timeout here for performance.
>  	 *
>  	 * The regbus read/write is on the critical path of Intel PAC N3000
> -	 * image programing. The time based timeout checking will add too much
> +	 * image programming. The time based timeout checking will add too much
>  	 * overhead on it. Usually the state changes in 1 or 2 loops on the
>  	 * test server, and we set 10000 times loop here for safety.
>  	 */
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96ba56c7..dac9c3d45e6c3 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -232,7 +232,7 @@ struct dfl_feature_irq_ctx {
>   * @id: sub feature id.
>   * @resource_index: each sub feature has one mmio resource for its registers.
>   *		    this index is used to find its mmio resource from the
> - *		    feature dev (platform device)'s reources.
> + *		    feature dev (platform device)'s resources.
>   * @ioaddr: mapped mmio resource address.
>   * @irq_ctx: interrupt context list.
>   * @nr_irqs: number of interrupt contexts.
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 6510c7803a784..d31eec32eb426 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -230,7 +230,7 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>   *
>   * Get an exclusive reference to the bridge and and it to the list.
>   *
> - * Return 0 for success, error code from of_fpga_bridge_get() othewise.
> + * Return 0 for success, error code from of_fpga_bridge_get() otherwise.
>   */
>  int of_fpga_bridge_get_to_list(struct device_node *np,
>  			       struct fpga_image_info *info,
> @@ -260,7 +260,7 @@ EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
>   *
>   * Get an exclusive reference to the bridge and and it to the list.
>   *
> - * Return 0 for success, error code from fpga_bridge_get() othewise.
> + * Return 0 for success, error code from fpga_bridge_get() otherwise.
>   */
>  int fpga_bridge_get_to_list(struct device *dev,
>  			    struct fpga_image_info *info,
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 07fa8d9ec6750..9b75bd4f93d8e 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -192,7 +192,7 @@ static void zynq_step_dma(struct zynq_fpga_priv *priv)
>  
>  	/* Once the first transfer is queued we can turn on the ISR, future
>  	 * calls to zynq_step_dma will happen from the ISR context. The
> -	 * dma_lock spinlock guarentees this handover is done coherently, the
> +	 * dma_lock spinlock guarantees this handover is done coherently, the
>  	 * ISR enable is put at the end to avoid another CPU spinning in the
>  	 * ISR on this lock.
>  	 */
> @@ -267,7 +267,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  		ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>  		if (!(ctrl & CTRL_SEC_EN_MASK)) {
>  			dev_err(&mgr->dev,
> -				"System not secure, can't use crypted bitstreams\n");
> +				"System not secure, can't use encrypted bitstreams\n");
>  			err = -EINVAL;
>  			goto out_err;
>  		}
> @@ -344,7 +344,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  
>  	/* set configuration register with following options:
>  	 * - enable PCAP interface
> -	 * - set throughput for maximum speed (if bistream not crypted)
> +	 * - set throughput for maximum speed (if bistream not encrypted)
>  	 * - set CPU in user mode
>  	 */
>  	ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 2bc3030a69e54..3a32b8e201857 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -110,7 +110,7 @@ struct fpga_image_info {
>   * @initial_header_size: Maximum number of bytes that should be passed into write_init
>   * @state: returns an enum value of the FPGA's state
>   * @status: returns status of the FPGA, including reconfiguration error code
> - * @write_init: prepare the FPGA to receive confuration data
> + * @write_init: prepare the FPGA to receive configuration data
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
>   * @write_complete: set FPGA to operating state after writing is done
> -- 
> 2.26.3
> 
Applied to for-next,

Thanks
