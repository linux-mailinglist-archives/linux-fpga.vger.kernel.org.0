Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0912216575
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jul 2020 06:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGGEkU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jul 2020 00:40:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46724 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGEkU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jul 2020 00:40:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id k5so370296plk.13;
        Mon, 06 Jul 2020 21:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTyDwQZyfS5JdKrzuL5HMoSjcvei51XSPWAcVQngrio=;
        b=S+gsPFaLmgvn5zfIf8ta9heHR7r4JBDO48RdfwbpzWVatgwSYeIJcrBlKZtOZGueYz
         fOZmTQ1i0fU2GiV2CvOLP3cN8Qm9CLADiQJw7VKNJstRW9ki7HijmIIxE5tOSZS77HG8
         ddFWlhxNqAjKWU6sbnVaK5cMKWPA0PJ6r9kIoFyRS5mYsnLx3+x2LE0O0oonBCqiaPj4
         kXkHltIXOGdUVcB9s1R+HWbNiI4sVl53bfFKo2h+pE88+u7gc1SkTfR8AitXjuNxgB+n
         PrtoAj9QqiqhD5IbYzbX8F84fQI9TPA7eKNLEtCg2W9mwwtnSnJTXmkdYC1EKfSLO/87
         cIKA==
X-Gm-Message-State: AOAM530S7fYcmmJr6SE9P27UwnzUYV65ekL8yEEhFrGOK91iugPusevv
        RzawSfMJYWXd/w0dfDCLHVlqdtwp99E=
X-Google-Smtp-Source: ABdhPJy0Co7XTeBeQ9IOJ5MIlhOHFJG9zTbKYrKXl+IQLWuvrTxbhTCRXH8pp75tuXWxNm7tF2zX9w==
X-Received: by 2002:a17:90a:e618:: with SMTP id j24mr2359572pjy.41.1594096819717;
        Mon, 06 Jul 2020 21:40:19 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c12sm21232908pfn.162.2020.07.06.21.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 21:40:19 -0700 (PDT)
Date:   Mon, 6 Jul 2020 21:40:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        mtosatti@redhat.com, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v7 7/7] Documentation: fpga: dfl: add descriptions for
 interrupt related interfaces.
Message-ID: <20200707044018.GD10464@epycbox.lan>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <1592280528-6350-8-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592280528-6350-8-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 16, 2020 at 12:08:48PM +0800, Xu Yilun wrote:
> This patch adds introductions of interrupt related interfaces for FME
> error reporting, port error reporting and AFU user interrupts features.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: Update Documents cause change of irq ioctl interfaces.
> v3: No change
> v4: Update interrupt support part.
> v5: No change
> v6: No change
> v7: No change
> ---
>  Documentation/fpga/dfl.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 978c4af..2df9a0a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -89,6 +89,8 @@ The following functions are exposed through ioctls:
>  - Program bitstream (DFL_FPGA_FME_PORT_PR)
>  - Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
>  - Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
> +- Get number of irqs of FME global error (DFL_FPGA_FME_ERR_GET_IRQ_NUM)
> +- Set interrupt trigger for FME error (DFL_FPGA_FME_ERR_SET_IRQ)
>  
>  More functions are exposed through sysfs
>  (/sys/class/fpga_region/regionX/dfl-fme.n/):
> @@ -149,6 +151,10 @@ The following functions are exposed through ioctls:
>  - Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
>  - Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
>  - Reset AFU (DFL_FPGA_PORT_RESET)
> +- Get number of irqs of port error (DFL_FPGA_PORT_ERR_GET_IRQ_NUM)
> +- Set interrupt trigger for port error (DFL_FPGA_PORT_ERR_SET_IRQ)
> +- Get number of irqs of UINT (DFL_FPGA_PORT_UINT_GET_IRQ_NUM)
> +- Set interrupt trigger for UINT (DFL_FPGA_PORT_UINT_SET_IRQ)
>  
>  DFL_FPGA_PORT_RESET:
>    reset the FPGA Port and its AFU. Userspace can do Port
> @@ -462,6 +468,19 @@ since they are system-wide counters on FPGA device.
>  The current driver does not support sampling. So "perf record" is unsupported.
>  
>  
> +Interrupt support
> +=================
> +Some FME and AFU private features are able to generate interrupts. As mentioned
> +above, users could call ioctl (DFL_FPGA_*_GET_IRQ_NUM) to know whether or how
> +many interrupts are supported for this private feature. Drivers also implement
> +an eventfd based interrupt handling mechanism for users to get notified when
> +interrupt happens. Users could set eventfds to driver via
> +ioctl (DFL_FPGA_*_SET_IRQ), and then poll/select on these eventfds waiting for
> +notification.
> +In Current DFL, 3 sub features (Port error, FME global error and AFU interrupt)
> +support interrupts.
> +
> +
>  Add new FIUs support
>  ====================
>  It's possible that developers made some new function blocks (FIUs) under this
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks!
