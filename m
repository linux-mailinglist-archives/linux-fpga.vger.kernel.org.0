Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38427F622
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 01:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgI3Xq7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Sep 2020 19:46:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgI3Xq7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Sep 2020 19:46:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id y14so2325273pgf.12;
        Wed, 30 Sep 2020 16:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5Sdq+uzDcVltZSM04qjX6MPWefRTcwpF7O+JWRb8xZQ=;
        b=qRf40PBrg6vPGxpUjnZOU2QSYdV+aZNlUCKVjj1CEoLyFtShL/P33Z0OnCaMJ4w1F5
         GNbo7cyWgpfbsyHoweqTGc0mb5eBExo9k2WP9eYwRHvcD4VlZ6JP9kQbLC7Ff1uemrgm
         LsyYou05HOcoKLrlfGsbtNh9ZnDiiiel1Eyp3f7mv/dRkUkjw2qK3006HqSnRWwvye0g
         zUSVsWEpCWD7G1LgTjOusEsk1Te9ckB7FEu4r9fb3zI034A2YDrb0Aw0uJZdXXc+xyX5
         vlSJMToAvJD44a3DG4wZNn1or0jlWGWMuILZj/hVM5HpUnSNjMx+xCMdbUvYCtaPgAPq
         T5Qg==
X-Gm-Message-State: AOAM533M+cfGx9ikNaYJQwKh1q62yE3bf4TFSAWsLhKUsk1WzFuvU1L7
        UXbIiH5reGzYtyKrdqUPVME=
X-Google-Smtp-Source: ABdhPJxJbgI18kg6TJGHsRuypGTbddXLkTe/KwmjJjKXfuSUG1F51+Jhba//y/EywtCJSIP5KeYCYA==
X-Received: by 2002:aa7:9518:0:b029:142:2501:35e3 with SMTP id b24-20020aa795180000b0290142250135e3mr4669251pfp.67.1601509618092;
        Wed, 30 Sep 2020 16:46:58 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id s8sm3643995pjm.7.2020.09.30.16.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:46:57 -0700 (PDT)
Date:   Wed, 30 Sep 2020 16:46:56 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 40/52] docs: fpga: replace :c:member: macros
Message-ID: <20200930234656.GB121420@archbook>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <720b01d37a7d6f50721d95988cfd9a9e463f43cd.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720b01d37a7d6f50721d95988cfd9a9e463f43cd.1601467849.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 30, 2020 at 03:25:03PM +0200, Mauro Carvalho Chehab wrote:
> Those macros are not doing the right thing with Sphinx 3,
> causing parse errors:
> 
> 	./Documentation/driver-api/fpga/fpga-mgr.rst:104: WARNING: Unparseable C cross-reference: 'fpga_manager->state'
> 	Invalid C declaration: Expected end of definition. [error at 12]
> 	  fpga_manager->state
> 	  ------------^
> 	./Documentation/driver-api/fpga/fpga-programming.rst:18: WARNING: Unparseable C cross-reference: 'fpga_region->info'
> 	Invalid C declaration: Expected end of definition. [error at 11]
> 	  fpga_region->info
> 	  -----------^
> 	./Documentation/driver-api/fpga/fpga-region.rst:62: WARNING: Unparseable C cross-reference: 'fpga_region->bridge_list'
> 	Invalid C declaration: Expected end of definition. [error at 11]
> 	  fpga_region->bridge_list
> 	  -----------^
> 	./Documentation/driver-api/fpga/fpga-region.rst:62: WARNING: Unparseable C cross-reference: 'fpga_region->get_bridges'
> 	Invalid C declaration: Expected end of definition. [error at 11]
> 	  fpga_region->get_bridges
> 	  -----------^
> 
> Replace them by :c:expr:, with does what's desired.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst         | 2 +-
>  Documentation/driver-api/fpga/fpga-programming.rst | 2 +-
>  Documentation/driver-api/fpga/fpga-region.rst      | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 22f7885b32c9..917ee22db429 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -101,7 +101,7 @@ in state.
>  API for implementing a new FPGA Manager driver
>  ----------------------------------------------
>  
> -* ``fpga_mgr_states`` —  Values for :c:member:`fpga_manager->state`.
> +* ``fpga_mgr_states`` —  Values for :c:expr:`fpga_manager->state`.
>  * struct fpga_manager —  the FPGA manager struct
>  * struct fpga_manager_ops —  Low level FPGA manager driver ops
>  * devm_fpga_mgr_create() —  Allocate and init a manager struct
> diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
> index f487ad64dfb9..002392dab04f 100644
> --- a/Documentation/driver-api/fpga/fpga-programming.rst
> +++ b/Documentation/driver-api/fpga/fpga-programming.rst
> @@ -15,7 +15,7 @@ the FPGA manager and bridges.  It will:
>   * lock the mutex of the region's FPGA manager
>   * build a list of FPGA bridges if a method has been specified to do so
>   * disable the bridges
> - * program the FPGA using info passed in :c:member:`fpga_region->info`.
> + * program the FPGA using info passed in :c:expr:`fpga_region->info`.
>   * re-enable the bridges
>   * release the locks
>  
> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
> index 3e52be7e2968..363a8171ab0a 100644
> --- a/Documentation/driver-api/fpga/fpga-region.rst
> +++ b/Documentation/driver-api/fpga/fpga-region.rst
> @@ -61,9 +61,9 @@ during the region's probe function.
>  
>  The FPGA region will need to specify which bridges to control while programming
>  the FPGA.  The region driver can build a list of bridges during probe time
> -(:c:member:`fpga_region->bridge_list`) or it can have a function that creates
> +(:c:expr:`fpga_region->bridge_list`) or it can have a function that creates
>  the list of bridges to program just before programming
> -(:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
> +(:c:expr:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
>  following APIs to handle building or tearing down that list.
>  
>  * fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
> -- 
> 2.26.2
> 
Thanks!
