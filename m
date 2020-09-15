Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C69269CCF
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIOD7s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:59:48 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33030 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOD7r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 23:59:47 -0400
Received: by mail-pj1-f67.google.com with SMTP id md22so6055850pjb.0;
        Mon, 14 Sep 2020 20:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kd64SOC74tP/NkN9zKlLUKoWiM2w+CddqcIQVYSvUh0=;
        b=ryKa+9ddDaTpAMk8boyYnZORGhV5E609RDxE9zllYWKS0Lpx+weyEoNMvB+xFoPUOV
         Y7PYbb+gTbg6+58AMJ3qnbbzbBB6OZhl9cZEm7sco9qfhofO2TdMsijPDvJTTMUYq5jQ
         s99yyBVle3DeVsypeLLcbGh0VxGTtr7ScveRK5aIt9LIaL/tsuq0U2Rr/vkZ+/OWGfqV
         A/p028FbdDGIVfqOZGs9CFEU6SSeCveoGRn8naf+JKGYTI5RNlbDkvXoDXk3MWTCLvjZ
         9wxwdOqS1mdnJMiPESTGxccf2QfQcGvSC8UxaUyHwc6tAbOKyWb3EcrMsxYnzPsxmUK9
         +8qg==
X-Gm-Message-State: AOAM533+66b98Mpt0zfeHrXAlrlROxEQtDCpfIQmqkqpRE8Qe/qXmRQP
        WtqozWFZG+wm6jEJ5x+vL+k=
X-Google-Smtp-Source: ABdhPJwwE/ozFjpRoQc7ES3d5BMTmNkZjpvLc2mEFgFTgXfcyxW5Xg88SPtTytGT5svrcINUFtkltQ==
X-Received: by 2002:a17:90a:62c4:: with SMTP id k4mr2323816pjs.174.1600142386607;
        Mon, 14 Sep 2020 20:59:46 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z18sm11668396pfn.186.2020.09.14.20.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:59:46 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:59:45 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        trix@redhat.com, lgoncalv@redhat.com
Subject: Re: [PATCH v2 3/4] fpga: dfl: fix the comments of type & feature_id
 fields
Message-ID: <20200915035945.GC2217@epycbox.lan>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
 <1600140473-12351-4-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600140473-12351-4-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 15, 2020 at 11:27:52AM +0800, Xu Yilun wrote:
> The description of feature_id in struct dfl_device is not accurate. In
> DFL specification the feature_id is the 12 bits field. The description
> in struct dfl_device_id is more clear so we make them aligned. We also
> made the similar fix for the type field.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/fpga/dfl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 3c69596..d5e050a 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -531,8 +531,8 @@ enum dfl_id_type {
>   *
>   * @dev: generic device interface.
>   * @id: id of the dfl device.
> - * @type: type of DFL FIU of the device. See enum dfl_id_type.
> - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
>   * @mmio_res: mmio resource of this dfl device.
>   * @irqs: list of Linux IRQ numbers of this dfl device.
>   * @num_irqs: number of IRQs supported by this dfl device.
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks
