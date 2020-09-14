Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18950269838
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 23:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgINVrB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 17:47:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42799 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINVq6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 17:46:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id d6so668410pfn.9;
        Mon, 14 Sep 2020 14:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7AxGeCPLtuiXnnosAChk+eah3HeQMSdm+VBaL/8iNeQ=;
        b=PE1IGej8ryB6qZC0gm0s67u/BL8g1c9KKloVkaCZvj9L7q9ntLp1KRiVfxuYJk1dEr
         VJhA/M57oZzVLEMvL/Ag1cLSPZZ6ENq4k9Ej4P6yKAH09JTiWtDtQD1ri/NhTic1t2Wj
         1J7SyL1CBMyZ8t6jjd9IzZDpe7s7H9ICx15MnF6WJFbPd548+2oR/xZDUfj/BlGjxSCH
         62G3oZdgHcbsveGwDag0Ggb6wIaF5KdAotyaBPzSSM3uDONClE+R5QXmqrC0KBVhRQNo
         6hRnsDZ7oBVCdAtiBcTpsaGd57jaYa7cq3lwEjHoSNfKilrIgALk0ShJwG6ADAJgtFTe
         EjHQ==
X-Gm-Message-State: AOAM533b3qJk4xJEAt3OsHH4rqpGxVkwBZuZ7OdZiyPJL9kME0OV6K/M
        0iUp+RnfEa9EPKjdzJ+WDWc=
X-Google-Smtp-Source: ABdhPJxHkRvmRUcHekmZ+kgZRH0hYjaX7QrITTOonjNOAKve5Azd15nHztSaIodnVsvIWpYH7UsTiQ==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:66b9 with SMTP id x124-20020a627c820000b029013c161166b9mr14506540pfc.4.1600120016849;
        Mon, 14 Sep 2020 14:46:56 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id w203sm11064404pfc.97.2020.09.14.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:46:56 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:46:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH v2 5/6] include: fpga: adi-axi-common.h: add definitions
 for supported FPGAs
Message-ID: <20200914214655.GA23848@archbook>
References: <20200810134252.68614-1-alexandru.ardelean@analog.com>
 <20200810134252.68614-6-alexandru.ardelean@analog.com>
 <0f9aa0ed-11a2-cf49-6c5d-ff36ba8ff9eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f9aa0ed-11a2-cf49-6c5d-ff36ba8ff9eb@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 10, 2020 at 07:07:14AM -0700, Tom Rix wrote:
> 
> On 8/10/20 6:42 AM, Alexandru Ardelean wrote:
> > From: Mircea Caprioru <mircea.caprioru@analog.com>
> >
> > All (newer) FPGA IP cores supported by Analog Devices, store information in
> > the synthesized designs. This information describes various parameters,
> > including the family of boards on which this is deployed, speed-grade, and
> > so on.
> >
> > Currently, some of these definitions are deployed mostly on Xilinx boards,
> > but they have been considered also for FPGA boards from other vendors.
> >
> > The register definitions are described at this link:
> >   https://wiki.analog.com/resources/fpga/docs/hdl/regmap
> > (the 'Base (common to all cores)' section).
> >
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> Thanks for changes.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> > ---
> >  include/linux/fpga/adi-axi-common.h | 103 ++++++++++++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >
> > diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> > index 141ac3f251e6..5c7d212a5d4a 100644
> > --- a/include/linux/fpga/adi-axi-common.h
> > +++ b/include/linux/fpga/adi-axi-common.h
> > @@ -13,6 +13,9 @@
> >  
> >  #define ADI_AXI_REG_VERSION			0x0000
> >  
> > +#define ADI_AXI_REG_FPGA_INFO			0x001C
> > +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
> > +
> >  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
> >  	(((major) << 16) | ((minor) << 8) | (patch))
> >  
> > @@ -20,4 +23,104 @@
> >  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
> >  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> >  
> > +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)		((val) & 0xffff)
> > +
> > +#define ADI_AXI_INFO_FPGA_TECH(info)		(((info) >> 24) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_FAMILY(info)		(((info) >> 16) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)	(((info) >> 8) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_DEV_PACKAGE(info)	((info) & 0xff)
> > +
> > +/**
> > + * FPGA Technology definitions
> > + */
> > +#define ADI_AXI_FPGA_TECH_XILINX_UNKNOWN 		0
> > +#define ADI_AXI_FPGA_TECH_XILINS_SERIES7		1
> > +#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE		2
> > +#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS	3
> > +
> > +#define ADI_AXI_FPGA_TECH_INTEL_UNKNOWN			100
> > +#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_5		101
> > +#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_10		102
> > +#define ADI_AXI_FPGA_TECH_INTEL_ARRIA_10		103
> > +#define ADI_AXI_FPGA_TECH_INTEL_STRATIX_10		104
> > +
> > +/**
> > + * FPGA Family definitions
> > + */
> > +#define ADI_AXI_FPGA_FAMILY_UNKNOWN			0
> > +
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_ARTIX		1
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_KINTEX		2
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_VIRTEX		3
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_ZYNQ			4
> > +
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_SX			1
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_GX			2
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_GT			3
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_GZ			4
> > +
> > +/**
> > + * FPGA Speed-grade definitions
> > + */
> > +#define ADI_AXI_FPGA_SPEED_GRADE_UNKNOWN		0
> > +
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1		10
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1L		11
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1H		12
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1HV		13
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1LV		14
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2		20
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2L		21
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV		22
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_3		30
> > +
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_1		1
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_2		2
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_3		3
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_4		4
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_5		5
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_6		6
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_7		7
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_8		8
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_9		9
> > +
> > +/**
> > + * FPGA Device Package definitions
> > + */
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_UNKNOWN		0
> > +
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RF		1
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FL		2
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FF		3
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FB		4
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_HC		5
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FH		6
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CS		7
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CP		8
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FT		9
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FG		10
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SB		11
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RB		12
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RS		13
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CL		14
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SF		15
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_BA		16
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FA		17
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FS		18
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FI		19
> > +
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_BGA		1
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PGA		2
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_FBGA		3
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_HBGA		4
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PDIP		5
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_EQFP		6
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PLCC		7
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PQFP		8
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_RQFP		9
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_TQFP		10
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UBGA		11
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UFBGA		12
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_MBGA		13
> > +
> >  #endif /* ADI_AXI_COMMON_H_ */
> 
Applied to for-next (with whitespace fix-up),

Thanks,
Moritz
