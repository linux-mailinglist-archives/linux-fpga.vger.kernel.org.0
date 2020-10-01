Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FD280782
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgJATH4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Oct 2020 15:07:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47029 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgJATH4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Oct 2020 15:07:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id b124so5450327pfg.13;
        Thu, 01 Oct 2020 12:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OF+/WWqy2ml+kJBEjYBraZTkFSg1lEvm3pja+j1FJ3U=;
        b=Sdb7XHBDD2koLGxBHMwtKvW+72tqy3Mi1GAF/s1AitVJfeU2QisIYn92k5zohjoiRR
         mEVl/sTGl6a4N1ELxYUhxbK5m4ldzUPV1Oci+PpB1H7r6/fcGm8PnRkfimNy2tvth6lw
         wSvPRhLefKQH2jde6MJxoIFb+DW8jbD1443lj9S1M/nrgyqvZ56/GGXE3I8R3uwZ+uYT
         rjgBRKMOzbuy6hcHS6anCEzYFMZKE3Bq7XI4jQDTL7C1xivdXz9aVLU8tbcdGCW1cYTl
         i0Ee5KUrTMrll5peBlsDacdS/Hw7yEUW7R1WTsJP/AWIHQuGVmuf6nq/ds6iE2fM7MBw
         2U5Q==
X-Gm-Message-State: AOAM5335o5erHI3k0QML7WLtMiIlG5g2MCoEhY5n8Anxdhb2j5i6GZp+
        JAJ7eq5auay0ZHIdlhc8TQQ=
X-Google-Smtp-Source: ABdhPJzAIlRmDJZipHrFBKSMcz+jWXLqwUIILsOjtfYdCFM9m6VcJdE10awRHmc34T/Hdo6tWqyC+g==
X-Received: by 2002:a17:902:ff07:b029:d1:e5fa:aa1d with SMTP id f7-20020a170902ff07b02900d1e5faaa1dmr8782666plj.84.1601579274789;
        Thu, 01 Oct 2020 12:07:54 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id j19sm7250249pfi.51.2020.10.01.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:07:54 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:07:53 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v1 01/12] fpga: fpga security manager class driver
Message-ID: <20201001190753.GD121420@archbook>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-2-russell.h.weight@intel.com>
 <20200916201604.GA1076460@epycbox.lan>
 <aab49157-5b2f-62b0-1682-635b6efbd546@intel.com>
 <20201001003101.GC121420@archbook>
 <baf8eec6-c89e-43fc-ab79-9bbc46acd208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf8eec6-c89e-43fc-ab79-9bbc46acd208@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Wed, Sep 30, 2020 at 06:07:00PM -0700, Russ Weight wrote:
> 
> Hi Moritz,
> 
> On 9/30/20 5:31 PM, Moritz Fischer wrote:
> > I think providing the devm_ managed APIs is nicer, and makes it easier
> > for the consumer of the API to do the right thing.
> 
> I see that the fpga_mgr code has support for two versions of the create()
> and register() functions, one uses the devm_ approach, and the other does
> not. Would also want to have two versions for the security manager?

The devm_fpga_mgr_create() just wraps the other one. I think that's a
good way to handle it for now.

I'd keep the breakdown the same.

Cheers,
Moritz
