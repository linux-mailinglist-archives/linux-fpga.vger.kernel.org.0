Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263F266ACC7
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Jan 2023 18:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjANRAi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Jan 2023 12:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjANRAh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 14 Jan 2023 12:00:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6F93D6;
        Sat, 14 Jan 2023 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=hxvdnhmwFp7Gsig4e5Q1Y6Qn7meRx4ipVDxeSJr2N/I=; b=qhiRzFhRl8ur4ty/gR9+zsmxaY
        ExY6aECA3/f7ZiUxblQJTV65jd+gnpqpmIlNOtarhuv8v7eI2vZfNArxxIS7S9F87UQmObgPLVSZ9
        Aiuw5kKflJx43iN3MY/6R6hq3xPGJ+ZDWRu5IjZF4RJN08VA3hLP7J3IG1x+EvDlgrXux/uLC53UY
        zHnrw0IIhdW30b6UxubuKnMHMNxFhnnBkawITfWjz0CQNuE+Ky1iv+uytdxgrP95k+s0llYsEi+ai
        7TcMlPxiDXtWAU+3ezEO7Wcq8Qie/CoxK6ugdKKvHyw6c3jBoP8tpIudc+Jp9vLiwPGKUoqzmRKOg
        UyNzCHhw==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGjtK-006Fa9-Gx; Sat, 14 Jan 2023 17:00:26 +0000
Message-ID: <78d502cf-9e68-5477-5685-cf0cc53b9b86@infradead.org>
Date:   Sat, 14 Jan 2023 09:00:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] fpga: dfl: more kernel-doc corrections
To:     Xu Yilun <yilun.xu@intel.com>, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230114155444.794712-1-yilun.xu@intel.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230114155444.794712-1-yilun.xu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/14/23 07:54, Xu Yilun wrote:
> Fix more kernel-doc warnings in drivers/fpga/:
> 
> $ ./scripts/kernel-doc -none drivers/fpga/*
> drivers/fpga/dfl-afu.h:61: warning: expecting prototype for struct fpga_afu_dma_region. Prototype was for struct dfl_afu_dma_region instead
> drivers/fpga/dfl-afu-region.c:52: warning: Function parameter or member 'pdata' not described in 'afu_mmio_region_add'
> drivers/fpga/dfl-fme-perf.c:161: warning: Function parameter or member 'node' not described in 'fme_perf_priv'
> drivers/fpga/dfl-fme-pr.h:70: warning: expecting prototype for struct dfl_fme_bridge_pdata. Prototype was for struct dfl_fme_br_pdata instead
> drivers/fpga/dfl.h:256: warning: Function parameter or member 'revision' not described in 'dfl_feature'
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/fpga/dfl-afu-region.c | 1 +
>  drivers/fpga/dfl-afu.h        | 2 +-
>  drivers/fpga/dfl-fme-perf.c   | 2 +-
>  drivers/fpga/dfl-fme-pr.h     | 2 +-
>  drivers/fpga/dfl.h            | 1 +
>  5 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
> index 0804b7a0c298..2e7b41629406 100644
> --- a/drivers/fpga/dfl-afu-region.c
> +++ b/drivers/fpga/dfl-afu-region.c
> @@ -39,6 +39,7 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
>  /**
>   * afu_mmio_region_add - add a mmio region to given feature dev.
>   *
> + * @pdata: afu platform device's pdata.
>   * @region_index: region index.
>   * @region_size: region size.
>   * @phys: region's physical address of this region.
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index e5020e2b1f3d..674e9772f0ea 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -41,7 +41,7 @@ struct dfl_afu_mmio_region {
>  };
>  
>  /**
> - * struct fpga_afu_dma_region - afu DMA region data structure
> + * struct dfl_afu_dma_region - afu DMA region data structure
>   *
>   * @user_addr: region userspace virtual address.
>   * @length: region length.
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 587c82be12f7..7422d2bc6f37 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -141,7 +141,7 @@
>   * @fab_port_id: used to indicate current working mode of fabric counters.
>   * @fab_lock: lock to protect fabric counters working mode.
>   * @cpu: active CPU to which the PMU is bound for accesses.
> - * @cpuhp_node: node for CPU hotplug notifier link.
> + * @node: node for CPU hotplug notifier link.
>   * @cpuhp_state: state for CPU hotplug notification;
>   */
>  struct fme_perf_priv {
> diff --git a/drivers/fpga/dfl-fme-pr.h b/drivers/fpga/dfl-fme-pr.h
> index 096a699089d3..761f80f63312 100644
> --- a/drivers/fpga/dfl-fme-pr.h
> +++ b/drivers/fpga/dfl-fme-pr.h
> @@ -58,7 +58,7 @@ struct dfl_fme_bridge {
>  };
>  
>  /**
> - * struct dfl_fme_bridge_pdata - platform data for FME bridge platform device.
> + * struct dfl_fme_br_pdata - platform data for FME bridge platform device.
>   *
>   * @cdev: container device.
>   * @port_id: port id.
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 06cfcd5e84bb..5fc424d505c8 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -231,6 +231,7 @@ struct dfl_feature_irq_ctx {
>   *
>   * @dev: ptr to pdev of the feature device which has the sub feature.
>   * @id: sub feature id.
> + * @revision: revision value of this sub feature.
>   * @resource_index: each sub feature has one mmio resource for its registers.
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s resources.

-- 
~Randy
