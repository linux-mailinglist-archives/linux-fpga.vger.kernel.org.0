Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5726D10A
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Sep 2020 04:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgIQCS3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Sep 2020 22:18:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43729 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQCSY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Sep 2020 22:18:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id t14so439386pgl.10;
        Wed, 16 Sep 2020 19:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oddmu3a6DAOAVtWoXMsWKj4HUjHptDRzvjsx4oGSL8I=;
        b=c8P9W3w20g3zBA6dekWcQjBbqc4GigPm/y9fjJlpGKM4VrD0Gp6XPrZm4fMoBmyrlF
         O16eYKUxAyPk/Eb8OG2O2oO6IOv0hGSe7Vc1CmjNZPMnkmxkqeEtXt8hDLSsA0rZv46f
         XkeY2VXUhaCWPhUGGbw0qo5YQ5x0N/6SDMNLmvnK9dxKVi+i/g4/dPVBF0MaumL+6wEQ
         JyKTMgqILhYskgz475D+0PmJWGSL3BE+jH+wiI8lQOB9mvPsnOlICs8mQvuRtW9PMuPA
         0Mf8hA8QcDDP6YPgegqe7Biz1s2NsdGOrwPkfoUf4oJOeDjNxcZYslHm66V9Xuzqg7gz
         VVqQ==
X-Gm-Message-State: AOAM532bJmNUaM3RmfK0uGdpdB4ZryFgYBBBeIv7kSf725TBCypS+fkf
        3vGLDrpunbpk7FF6DbL71m4=
X-Google-Smtp-Source: ABdhPJw3uN6pysDRMiQRII0m3fq07Tt0wIgCsWU7b8yjD7cmL/etmfDyyog6RaTR3LUXxJzWJ7igVQ==
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a12c with SMTP id j128-20020a6255860000b029013ed13da12cmr24687727pfb.20.1600309103673;
        Wed, 16 Sep 2020 19:18:23 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id f12sm14607661pfa.31.2020.09.16.19.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 19:18:23 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:18:22 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 next] fpga: dfl: n3000-nios: Make m10_n3000_info static
Message-ID: <20200917021822.GA1081552@epycbox.lan>
References: <20200917021240.40252-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917021240.40252-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 17, 2020 at 10:12:40AM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/fpga/dfl-n3000-nios.c:392:23: warning:
>  symbol 'm10_n3000_info' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/fpga/dfl-n3000-nios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> index 5088f8f0e0cd..686813b59d33 100644
> --- a/drivers/fpga/dfl-n3000-nios.c
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -389,7 +389,7 @@ static int n3000_nios_init_done_check(struct n3000_nios *ns)
>  	return ret;
>  }
>  
> -struct spi_board_info m10_n3000_info = {
> +static struct spi_board_info m10_n3000_info = {
>  	.modalias = "m10-n3000",
>  	.max_speed_hz = 12500000,
>  	.bus_num = 0,
> -- 
> 2.17.1
> 
Applied to for-next,

Thanks
