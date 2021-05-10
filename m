Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C720D379661
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhEJRtq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 13:49:46 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:39893 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhEJRtq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 May 2021 13:49:46 -0400
Received: by mail-pj1-f44.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so10506315pjd.4;
        Mon, 10 May 2021 10:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HDzjl09PFmzZNoD1Zf7/Ui+XEMBguLIbUNelx9dOrmU=;
        b=RYSM5VSqWyJvJAqryqzo8hK3+GySp49hr6gKl05X9kn1f3Z2Z5POLx+4PthvQcKer1
         MsbLIJ4LUCn46GcWSsDjQWyD41Dgwa9PZEsrdXFT8ZdXYoluA3Dd6TqW8lghC7otjGzx
         EV/NjhjWuD66OYMTzbCQZxDEVczBhSeXFOdMtcg0aX4lq6do6myfRzxNK+gonqdQLtBG
         D64OTfk0YUMgPb/kmwI6e5f/xDt3NSgQsIU5StnvhxWBw0bliUMSKDXKYzlN2m3D8O57
         qigVh1Bz101Ro3obddPCTB83cvLjPtTONNfPylYJgF0N9rgtxIcyUXz2waR7JKHPWG0s
         gRpA==
X-Gm-Message-State: AOAM531TCFahrYZ1d+GRwdiDFgJfurhZ655DERea4jnk7ik8oEdoAkVZ
        IpcCf4JWgQqVPA3uLhH5kloaSY5Sq9Z5CQ==
X-Google-Smtp-Source: ABdhPJwk5+EXIrC7BR54P3ComKj77R/Osy3QeJwej+096Kq8agrA7ZWJks/riDjEv8LJRParSnS6Aw==
X-Received: by 2002:a17:902:9a87:b029:ed:ea18:b2f3 with SMTP id w7-20020a1709029a87b02900edea18b2f3mr25096887plp.69.1620668920722;
        Mon, 10 May 2021 10:48:40 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 1sm11391023pfv.159.2021.05.10.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:48:40 -0700 (PDT)
Date:   Mon, 10 May 2021 10:48:38 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/53] docs: driver-api: fpga: avoid using UTF-8 chars
Message-ID: <YJlx9vLCleEMg+Hg@epycbox.lan>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <10fced4bcc033f4683fae41db0c494c1d3503ccb.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10fced4bcc033f4683fae41db0c494c1d3503ccb.1620641727.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 10, 2021 at 12:26:25PM +0200, Mauro Carvalho Chehab wrote:
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+2014 ('—'): EM DASH
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/driver-api/fpga/fpga-bridge.rst | 10 +++++-----
>  Documentation/driver-api/fpga/fpga-mgr.rst    | 12 +++++------
>  .../driver-api/fpga/fpga-programming.rst      |  8 ++++----
>  Documentation/driver-api/fpga/fpga-region.rst | 20 +++++++++----------
>  4 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
> index 198aadafd3e7..8d650b4e2ce6 100644
> --- a/Documentation/driver-api/fpga/fpga-bridge.rst
> +++ b/Documentation/driver-api/fpga/fpga-bridge.rst
> @@ -4,11 +4,11 @@ FPGA Bridge
>  API to implement a new FPGA bridge
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -* struct fpga_bridge — The FPGA Bridge structure
> -* struct fpga_bridge_ops — Low level Bridge driver ops
> -* devm_fpga_bridge_create() — Allocate and init a bridge struct
> -* fpga_bridge_register() — Register a bridge
> -* fpga_bridge_unregister() — Unregister a bridge
> +* struct fpga_bridge - The FPGA Bridge structure
> +* struct fpga_bridge_ops - Low level Bridge driver ops
> +* devm_fpga_bridge_create() - Allocate and init a bridge struct
> +* fpga_bridge_register() - Register a bridge
> +* fpga_bridge_unregister() - Unregister a bridge
>  
>  .. kernel-doc:: include/linux/fpga/fpga-bridge.h
>     :functions: fpga_bridge
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 917ee22db429..4d926b452cb3 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -101,12 +101,12 @@ in state.
>  API for implementing a new FPGA Manager driver
>  ----------------------------------------------
>  
> -* ``fpga_mgr_states`` —  Values for :c:expr:`fpga_manager->state`.
> -* struct fpga_manager —  the FPGA manager struct
> -* struct fpga_manager_ops —  Low level FPGA manager driver ops
> -* devm_fpga_mgr_create() —  Allocate and init a manager struct
> -* fpga_mgr_register() —  Register an FPGA manager
> -* fpga_mgr_unregister() —  Unregister an FPGA manager
> +* ``fpga_mgr_states`` -  Values for :c:expr:`fpga_manager->state`.
> +* struct fpga_manager -  the FPGA manager struct
> +* struct fpga_manager_ops -  Low level FPGA manager driver ops
> +* devm_fpga_mgr_create() -  Allocate and init a manager struct
> +* fpga_mgr_register() -  Register an FPGA manager
> +* fpga_mgr_unregister() -  Unregister an FPGA manager
>  
>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
>     :functions: fpga_mgr_states
> diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
> index 002392dab04f..fb4da4240e96 100644
> --- a/Documentation/driver-api/fpga/fpga-programming.rst
> +++ b/Documentation/driver-api/fpga/fpga-programming.rst
> @@ -84,10 +84,10 @@ will generate that list.  Here's some sample code of what to do next::
>  API for programming an FPGA
>  ---------------------------
>  
> -* fpga_region_program_fpga() —  Program an FPGA
> -* fpga_image_info() —  Specifies what FPGA image to program
> -* fpga_image_info_alloc() —  Allocate an FPGA image info struct
> -* fpga_image_info_free() —  Free an FPGA image info struct
> +* fpga_region_program_fpga() -  Program an FPGA
> +* fpga_image_info() -  Specifies what FPGA image to program
> +* fpga_image_info_alloc() -  Allocate an FPGA image info struct
> +* fpga_image_info_free() -  Free an FPGA image info struct
>  
>  .. kernel-doc:: drivers/fpga/fpga-region.c
>     :functions: fpga_region_program_fpga
> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
> index 363a8171ab0a..2636a27c11b2 100644
> --- a/Documentation/driver-api/fpga/fpga-region.rst
> +++ b/Documentation/driver-api/fpga/fpga-region.rst
> @@ -45,19 +45,19 @@ An example of usage can be seen in the probe function of [#f2]_.
>  API to add a new FPGA region
>  ----------------------------
>  
> -* struct fpga_region — The FPGA region struct
> -* devm_fpga_region_create() — Allocate and init a region struct
> -* fpga_region_register() —  Register an FPGA region
> -* fpga_region_unregister() —  Unregister an FPGA region
> +* struct fpga_region - The FPGA region struct
> +* devm_fpga_region_create() - Allocate and init a region struct
> +* fpga_region_register() -  Register an FPGA region
> +* fpga_region_unregister() -  Unregister an FPGA region
>  
>  The FPGA region's probe function will need to get a reference to the FPGA
>  Manager it will be using to do the programming.  This usually would happen
>  during the region's probe function.
>  
> -* fpga_mgr_get() — Get a reference to an FPGA manager, raise ref count
> -* of_fpga_mgr_get() —  Get a reference to an FPGA manager, raise ref count,
> +* fpga_mgr_get() - Get a reference to an FPGA manager, raise ref count
> +* of_fpga_mgr_get() -  Get a reference to an FPGA manager, raise ref count,
>    given a device node.
> -* fpga_mgr_put() — Put an FPGA manager
> +* fpga_mgr_put() - Put an FPGA manager
>  
>  The FPGA region will need to specify which bridges to control while programming
>  the FPGA.  The region driver can build a list of bridges during probe time
> @@ -66,11 +66,11 @@ the list of bridges to program just before programming
>  (:c:expr:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
>  following APIs to handle building or tearing down that list.
>  
> -* fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
> +* fpga_bridge_get_to_list() - Get a ref of an FPGA bridge, add it to a
>    list
> -* of_fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
> +* of_fpga_bridge_get_to_list() - Get a ref of an FPGA bridge, add it to a
>    list, given a device node
> -* fpga_bridges_put() — Given a list of bridges, put them
> +* fpga_bridges_put() - Given a list of bridges, put them
>  
>  .. kernel-doc:: include/linux/fpga/fpga-region.h
>     :functions: fpga_region
> -- 
> 2.30.2
> 

Applied to for-next,

Thanks
