Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A442269CCA
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIOD7e (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:59:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42477 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgIOD73 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 23:59:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id d6so1149831pfn.9;
        Mon, 14 Sep 2020 20:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/pseMDxGgOy9sMfqXmUqWf/bvkoNENN6WX97+nvh5w=;
        b=IC1BaSvv8ejL//TO8AzV8d9RIy1O0cKeJpiBasQJ9uEX0OlsSZ9Vx5GHIXun+uoj6m
         sIzo15SOk1RIbCUIVKnrWocVj6C/s4HL109HsMzU4Xyij/ic0uprs5u+HofSBMvRInb/
         TjkG7Piky0JA7t4yRHlegPcpoWt84RmDdr3K0fg31W/jDMEMQpLDYbIMKCv62AfboHL8
         RDqFg91U4L7gIfo2V3wEHnwdZylHAUQN4fZG/B4bcL7qXSK4MduR+phWzry6kF+rBChN
         VVJMSJXJJwfY9WbGeLplxLD676ltImcvxztmoXDAMfVORNajtniLCJxXFctoW75mz5i7
         ivPw==
X-Gm-Message-State: AOAM532/Mc7KUIVjOi5hdH8hnCXn+OJokJzGvQ8evl4xkdew5tT7qFWZ
        Lxh1AQ0fUtp5/uONt2uF488=
X-Google-Smtp-Source: ABdhPJxGz148oikDBRZ+3ZSTEhGcw/NZFWYsqzSYsdYRHwvsHLyfCqTuyt/5sDRC2Y1uBH1SaBAZEw==
X-Received: by 2002:a62:503:0:b029:13e:d13d:a0f9 with SMTP id 3-20020a6205030000b029013ed13da0f9mr15796057pff.21.1600142368047;
        Mon, 14 Sep 2020 20:59:28 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id i2sm9973815pfq.89.2020.09.14.20.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:59:27 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:59:27 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 2/4] dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Message-ID: <20200915035927.GB2217@epycbox.lan>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
 <1600140473-12351-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600140473-12351-3-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 15, 2020 at 11:27:51AM +0800, Xu Yilun wrote:
> Device Feature List (DFL) is a linked list of feature headers within the
> device MMIO space. It is used by FPGA to enumerate multiple sub features
> within it. Each feature can be uniquely identified by DFL type and
> feature id, which can be read out from feature headers.
> 
> A dfl bus helps DFL framework modularize DFL device drivers for different
> sub features. The dfl bus matches its devices and drivers by DFL type and
> feature id.
> 
> This patch add dfl bus support to MODULE_DEVICE_TABLE() by adding info
> about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
> point in file2alias.c.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: add comments for the format of modalias
> ---
>  scripts/mod/devicetable-offsets.c |  4 ++++
>  scripts/mod/file2alias.c          | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 27007c1..d8350ee 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -243,5 +243,9 @@ int main(void)
>  	DEVID(mhi_device_id);
>  	DEVID_FIELD(mhi_device_id, chan);
>  
> +	DEVID(dfl_device_id);
> +	DEVID_FIELD(dfl_device_id, type);
> +	DEVID_FIELD(dfl_device_id, feature_id);
> +
>  	return 0;
>  }
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 2417dd1..9fd2e60 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1368,6 +1368,22 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
>  	return 1;
>  }
>  
> +/* Looks like: dfl:tNfN */
> +static int do_dfl_entry(const char *filename, void *symval, char *alias)
> +{
> +	DEF_FIELD(symval, dfl_device_id, type);
> +	DEF_FIELD(symval, dfl_device_id, feature_id);
> +
> +	/*
> +	 * type contains 4 valid bits and feature_id contains 12 valid bits
> +	 * according to DFL specification.
> +	 */
> +	sprintf(alias, "dfl:t%01Xf%03X", type, feature_id);
> +
> +	add_wildcard(alias);
> +	return 1;
> +}
> +
>  /* Does namelen bytes of name exactly match the symbol? */
>  static bool sym_is(const char *name, unsigned namelen, const char *symbol)
>  {
> @@ -1442,6 +1458,7 @@ static const struct devtable devtable[] = {
>  	{"tee", SIZE_tee_client_device_id, do_tee_entry},
>  	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
>  	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
> +	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
>  };
>  
>  /* Create MODULE_ALIAS() statements.
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
