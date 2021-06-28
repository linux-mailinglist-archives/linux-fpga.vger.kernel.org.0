Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BDD3B689E
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhF1Sm5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 14:42:57 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:40539 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhF1Sm4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Jun 2021 14:42:56 -0400
Received: by mail-pj1-f48.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so65135pjb.5;
        Mon, 28 Jun 2021 11:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t33UQ33a9u7T7hl2VjGPYacvipLC+DJfwN0oYI3tbdA=;
        b=XRxUYq59rJNnW2it6qwzlk8iv9Yp+At14qq//POQckt21GjgcvuWDU/p1U6auEvOvg
         ZsBP0QaEbdCCNfL1MhpOTaMCEKIVeIQtwYmhkH9DAfN+YqJE87HwM93NsSaYlJ2Ko9XL
         tC8rAwAmkHii6+MxGCkoWu7RsCOE1YV+YILRGPcwpI3YKctberuvnQiBYIBedevn7KTj
         QClmf5f/nCK5Z0RwbtSbmZV6JOLPfvptusMsRgZeZ25fduNYGAgAHHnG8DtJQOeC2hlN
         q05B5OBXQeEXRjQbOrkQ4YbmUUhU+ppb2lSMdaVyj0dawc9/XGKzgKA4AHVf8YyRAKGS
         bWqQ==
X-Gm-Message-State: AOAM530LFaUbek4N5YiXnhylFC13+JNf6Jci/ivfjqq/u/0K3e1e8kJE
        UIGT74gxHztFTOQ5EgSvVEc=
X-Google-Smtp-Source: ABdhPJwFv7X0ZsN9IyqFwDLoc+nI2ihpePRwMm6qFwPp65TtsWX6OottLedU4r0bEFcHQEouXhywNQ==
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr3972427pjs.47.1624905629885;
        Mon, 28 Jun 2021 11:40:29 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id gl17sm226682pjb.13.2021.06.28.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:40:29 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:40:28 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     will@kernel.org, hao.wu@intel.com, mark.rutland@arm.com,
        trix@redhat.com, yilun.xu@intel.com, luwei.kang@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        maddy@linux.vnet.ibm.com, atrajeev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        rnsastry@linux.ibm.com
Subject: Re: [RFC] fpga: dfl: fme: Fix cpu hotplug code
Message-ID: <YNoXnHq+nlJhO8o6@epycbox.lan>
References: <20210628071546.167088-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628071546.167088-1-kjain@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 28, 2021 at 12:45:46PM +0530, Kajol Jain wrote:
> Commit 724142f8c42a ("fpga: dfl: fme: add performance
> reporting support") added performance reporting support
> for FPGA management engine via perf.
> 
> It also added cpu hotplug feature but it didn't add
> pmu migration call in cpu offline function.
> This can create an issue incase the current designated
> cpu being used to collect fme pmu data got offline,
> as based on current code we are not migrating fme pmu to
> new target cpu. Because of that perf will still try to
> fetch data from that offline cpu and hence we will not
> get counter data.
> 
> Patch fixed this issue by adding pmu_migrate_context call
> in fme_perf_offline_cpu function.
> 
> Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

You might want to Cc: stable@vger.kernel.org if it fixes an actual bug.
> ---
>  drivers/fpga/dfl-fme-perf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> ---
> - This fix patch is not tested (as I don't have required environment).
>   But issue mentioned in the commit msg can be re-created, by starting any
>   fme_perf event and while its still running, offline current designated
>   cpu pointed by cpumask file. Since current code didn't migrating pmu,
>   perf gonna try getting counts from that offlined cpu and hence we will
>   not get event data.
> ---
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 4299145ef347..b9a54583e505 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -953,6 +953,10 @@ static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  		return 0;
>  
>  	priv->cpu = target;
> +
> +	/* Migrate fme_perf pmu events to the new target cpu */
> +	perf_pmu_migrate_context(&priv->pmu, cpu, target);
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 
- Moritz
