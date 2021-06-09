Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44E3A1B2C
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFIQrY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 12:47:24 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:45965 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFIQrX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Jun 2021 12:47:23 -0400
Received: by mail-pg1-f174.google.com with SMTP id q15so19935476pgg.12
        for <linux-fpga@vger.kernel.org>; Wed, 09 Jun 2021 09:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9JjsQpokxKgTZs6W45y1oJN7ajwkOZ3jzmcVEdX3slM=;
        b=pams13acezoqj4xUYINJroVhlEPFVnL+tFQzpk9rWAI9G1w10ax9Ids6g1Byxb0oRX
         jeKMmgZwH1VKwZURIZmFNBVRqkTvN3cH+rmZOxdOkHAf+SSfTG31u8Ux+gedI9W6rGvd
         6d2aMFbn1lMR+fPEnC0BZE+A4dr3qDm+pGagEWdaHt7eHBaqLCAZpZuZFx/t3OLVM9uR
         6xX1I33z6HFhFHm7LtQpo7bSKa/9QyvejIjh2oCTfIKnh6SVj0XSuNkrGhL+5qOGwgav
         dheq6fcLM4As53NGoQ1QUSjZF1lPI9D0cnmNXXg4thUmPzBFa8R5RV+B9OwtxJkk3l6I
         aYWQ==
X-Gm-Message-State: AOAM530qh65YQU+Eic/N6QfitW0YrR3cvCubk86UjXWQfdMlhh/RCUvP
        eedVAhGZrmmnD3mc5Cr6qek=
X-Google-Smtp-Source: ABdhPJx1OUDM4SuATvoa8Yui0LXdpVFZvWUsqF8Zg5Y1+aYrG650qyBIFXFXQ6AAOuo7n6HTwk4bYw==
X-Received: by 2002:aa7:9384:0:b029:2cc:5e38:933a with SMTP id t4-20020aa793840000b02902cc5e38933amr691670pfe.81.1623257117170;
        Wed, 09 Jun 2021 09:45:17 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y190sm132541pfc.85.2021.06.09.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:45:16 -0700 (PDT)
Date:   Wed, 9 Jun 2021 09:45:15 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [PATCH v1 2/5] fpga: altera-pr-ip: Remove fpga_mgr_unregister()
 call
Message-ID: <YMDwGwJTebfq4wWl@epycbox.lan>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
 <20210609004925.238044-3-russell.h.weight@intel.com>
 <20210609153725.GB1994229@yilunxu-OptiPlex-7050>
 <a764584a-a1f8-88dd-2728-9e4092784717@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a764584a-a1f8-88dd-2728-9e4092784717@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 09:25:31AM -0700, Russ Weight wrote:
> 
> 
> On 6/9/21 8:37 AM, Xu Yilun wrote:
> > On Tue, Jun 08, 2021 at 05:49:22PM -0700, Russ Weight wrote:
> >> The altera-pr-ip driver uses the devm_fpga_mgr_register() call, so it is
> >> unnecessary to call fpga_mgr_unregister(). Also, mgr is no longer stored
> >> in the dev.driver_data, so remove the call to dev_get_drvdata().
> >>
> >> alt_pr_unregister() is now an empty function, but is left intact because
> >> it is an exported symbol.
> > I don't see this function be called anywhere, so could we just remove
> > it?
> >
> > Any impact we remove an exported symbol that is not used?
> 
> Only if there are out-of-tree drivers that use it. What do other's think? Can we remove this?

We don't care about out-of-tree drivers. Please remove it.

- Moritz
