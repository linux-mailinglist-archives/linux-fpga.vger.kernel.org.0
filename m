Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD35320BF5
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 18:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBUROR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 12:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhBURON (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 21 Feb 2021 12:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613927563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxBlKfrt1x0wZ31in/ErLK3hWFS9EYwmLoaoSU/r00g=;
        b=dvKQl2OpTIZhFDWFKEaZsD25oAxwp7VTEuydKmr6MahrAs109Fs4uDuSPUk9iw1agrmXPD
        xUb/8rZORPJ5OJtIFu/LybCVyhuSrYBzcyregcgyUIYc8T335N6D+FsHMJ+lpnpFvi2AZI
        LMeY1Zi9b8uOl9YEl48X3EL4dqMA/v8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-42r60SshMJyqKNs-lfpbVw-1; Sun, 21 Feb 2021 12:12:41 -0500
X-MC-Unique: 42r60SshMJyqKNs-lfpbVw-1
Received: by mail-qk1-f197.google.com with SMTP id y79so7437647qka.23
        for <linux-fpga@vger.kernel.org>; Sun, 21 Feb 2021 09:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KxBlKfrt1x0wZ31in/ErLK3hWFS9EYwmLoaoSU/r00g=;
        b=RUNI/scjq+5SOavjZMHqBrUKiw9rouRNguGE9rKuTL1HKLRLUf/zcvoXIanu/2Vc9C
         SEvtGNyNTxbCRU5C0NJ3V7ZmqPwnjwX5DBdJr4zIq5HbinNOkpc39IkXHpC/XUoh5jvU
         Ig4N7cyuuvDo9SifXCBxneE+xmMSLyY5wxpbIrLZi5+fTbQS3UA2d7LfArdks51S4Y7n
         1AZIfqEjOwhzXfz2lEjTzkuPTvSCaj0zCmpGCTzfNe5HzSHwKqna9UTx6RNzpcqJVPd6
         X8f19//tDG4tvSkteT6j2Ko+YdFb+74UIGX4E49qwCC1YGwwDtfEK2YBzhROtPFbaF3F
         HoqA==
X-Gm-Message-State: AOAM532yLZxi3xeiClGkQkFOw+h/KpJmEFatO0pymrBj/kO7U3uk6Vwd
        D4w+30rQP0bh5oPfR+zFb+AlW8+pERLt0cVjlcI/6q4eXgE6ThReXVWk35jr1hAb7BxXBN6UIbg
        pCr8JpwMEZwSJiyZynEmTnQ==
X-Received: by 2002:a05:622a:390:: with SMTP id j16mr16959215qtx.206.1613927560846;
        Sun, 21 Feb 2021 09:12:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSdrGqGtvexX+M09FE56gAk73ite0JDJ6IOvwbBSppJimF8GOlZhxN0n8KBG32vKopSuu68w==
X-Received: by 2002:a05:622a:390:: with SMTP id j16mr16959155qtx.206.1613927560157;
        Sun, 21 Feb 2021 09:12:40 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a186sm11013316qkd.63.2021.02.21.09.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 09:12:39 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 03/18] fpga: xrt: xclbin file helper
 functions
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-4-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4628ef05-27d1-b92f-9126-27a1f810c608@redhat.com>
Date:   Sun, 21 Feb 2021 09:12:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-4-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Alveo FPGA firmware and partial reconfigure file are in xclbin format.
This code enumerates and extracts
>  Add
> code to enumerate and extract sections from xclbin files. xclbin.h is cross
> platform and used across all platforms and OS
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/xclbin-helper.h |  52 +++
>  drivers/fpga/xrt/lib/xclbin.c            | 394 ++++++++++++++++++++++
>  include/uapi/linux/xrt/xclbin.h          | 408 +++++++++++++++++++++++
>  3 files changed, 854 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>  create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>  create mode 100644 include/uapi/linux/xrt/xclbin.h
>
> diff --git a/drivers/fpga/xrt/include/xclbin-helper.h b/drivers/fpga/xrt/include/xclbin-helper.h
> new file mode 100644
> index 000000000000..68218efc9d0b
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xclbin-helper.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Runtime (XRT) driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *    David Zhang <davidzha@xilinx.com>
> + *    Sonal Santan <sonal.santan@xilinx.com>
> + */
> +
> +#ifndef _XRT_XCLBIN_H
> +#define _XRT_XCLBIN_H

The header guard should match the filename.

> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/xrt/xclbin.h>
> +
> +#define ICAP_XCLBIN_V2	"xclbin2"
> +#define DMA_HWICAP_BITFILE_BUFFER_SIZE 1024
> +#define MAX_XCLBIN_SIZE (1024 * 1024 * 1024) /* Assuming xclbin <= 1G, always */
#defines should have a prefix, maybe XRT_ or XCLBIN_
> +
> +enum axlf_section_kind;
> +struct axlf;
> +
> +/**
> + * Bitstream header information as defined by Xilinx tools.
> + * Please note that this struct definition is not owned by the driver.
> + */
> +struct hw_icap_bit_header {

File headers usually have fixed length fields like uint32_t

Is this a structure the real header is converted into ?

> +	unsigned int header_length;     /* Length of header in 32 bit words */
> +	unsigned int bitstream_length;  /* Length of bitstream to read in bytes*/
> +	unsigned char *design_name;     /* Design name get from bitstream */
> +	unsigned char *part_name;       /* Part name read from bitstream */
> +	unsigned char *date;           /* Date read from bitstream header */
> +	unsigned char *time;           /* Bitstream creation time */
> +	unsigned int magic_length;      /* Length of the magic numbers */
> +	unsigned char *version;		/* Version string */
> +};
> +
> +const char *xrt_xclbin_kind_to_string(enum axlf_section_kind kind);

Only add decl's that are using in multiple files.

This is only defined in xclbin.c, why does it need to be in the header ?

> +int xrt_xclbin_get_section(const struct axlf *xclbin,
> +			   enum axlf_section_kind kind, void **data,
> +			   uint64_t *len);
> +int xrt_xclbin_get_metadata(struct device *dev, const struct axlf *xclbin, char **dtb);
> +int xrt_xclbin_parse_bitstream_header(const unsigned char *data,
> +				      unsigned int size,
> +				      struct hw_icap_bit_header *header);
> +void xrt_xclbin_free_header(struct hw_icap_bit_header *header);
> +const char *xrt_clock_type2epname(enum CLOCK_TYPE type);
CLOCK_TYPE needs a prefix, something like XCLBIN_CLOCK_TYPE
> +
> +#endif /* _XRT_XCLBIN_H */
> diff --git a/drivers/fpga/xrt/lib/xclbin.c b/drivers/fpga/xrt/lib/xclbin.c
> new file mode 100644
> index 000000000000..47dc6ca25c1b
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xclbin.c
> @@ -0,0 +1,394 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Driver XCLBIN parser
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors: David Zhang <davidzha@xilinx.com>
> + */
> +
> +#include <asm/errno.h>
> +#include <linux/vmalloc.h>
> +#include <linux/device.h>
> +#include "xclbin-helper.h"
> +#include "metadata.h"
> +
What is XHI ?  Maybe expand this, at the lease should comment
> +/* Used for parsing bitstream header */
> +#define XHI_EVEN_MAGIC_BYTE     0x0f
> +#define XHI_ODD_MAGIC_BYTE      0xf0
> +
> +/* Extra mode for IDLE */
> +#define XHI_OP_IDLE  -1
> +#define XHI_BIT_HEADER_FAILURE -1
> +
> +/* The imaginary module length register */
> +#define XHI_MLR                  15
> +
> +static inline unsigned char xhi_data_and_inc(const unsigned char *d, int *i, int sz)
could move to the *.h
> +{_
> +	unsigned char data;
> +
> +	if (*i >= sz)
> +		return -1;
The return value of this funtion is not always checked, at the least add a dev_err here
> +
> +	data = d[*i];
> +	(*i)++;
> +
> +	return data;
> +}
> +
> +static const struct axlf_section_header *
> +xrt_xclbin_get_section_hdr(const struct axlf *xclbin,
> +			   enum axlf_section_kind kind)
> +{
> +	int i = 0;
> +
> +	for (i = 0; i < xclbin->m_header.m_numSections; i++) {
> +		if (xclbin->m_sections[i].m_sectionKind == kind)
> +			return &xclbin->m_sections[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int
> +xrt_xclbin_check_section_hdr(const struct axlf_section_header *header,
> +			     u64 xclbin_len)
> +{
> +	int ret;
> +
> +	ret = (header->m_sectionOffset + header->m_sectionSize) > xclbin_len ? -EINVAL : 0;

Tristate is harder to read, consider replacing with if()

int ret = 0

if ()

  ret =


> +
> +	return ret;
> +}
> +
> +static int xrt_xclbin_section_info(const struct axlf *xclbin,
> +				   enum axlf_section_kind kind,
> +				   u64 *offset, u64 *size)
> +{
> +	const struct axlf_section_header *mem_header = NULL;
> +	u64 xclbin_len;
> +	int err = 0;
> +
> +	mem_header = xrt_xclbin_get_section_hdr(xclbin, kind);
> +	if (!mem_header)
> +		return -EINVAL;
> +
> +	xclbin_len = xclbin->m_header.m_length;
> +	if (xclbin_len > MAX_XCLBIN_SIZE)
> +		return -EINVAL;

This check can be added to the function call..

or the sanity checking added to the earier call to *get_section_hdr

There a number of small functions that can be combined.

> +
> +	err = xrt_xclbin_check_section_hdr(mem_header, xclbin_len);
> +	if (err)
> +		return err;
> +
> +	*offset = mem_header->m_sectionOffset;
> +	*size = mem_header->m_sectionSize;
> +
> +	return 0;
> +}
> +
> +/* caller should free the allocated memory for **data */

must free

This comment also needs to be with the *.h decl

> +int xrt_xclbin_get_section(const struct axlf *buf,
> +			   enum axlf_section_kind kind,
> +			   void **data, u64 *len)
> +{
> +	const struct axlf *xclbin = (const struct axlf *)buf;
> +	void *section = NULL;
> +	int err = 0;
> +	u64 offset = 0;
> +	u64 size = 0;
> +
> +	err = xrt_xclbin_section_info(xclbin, kind, &offset, &size);
> +	if (err)
> +		return err;
> +
> +	section = vmalloc(size);
> +	if (!section)
> +		return -ENOMEM;
> +
> +	memcpy(section, ((const char *)xclbin) + offset, size);
> +
> +	*data = section;

a general comment

for exported function checking the validity of the inputs in more important.

here you assume **data is valid, really you should check.

> +	if (len)
> +		*len = size;
len setting being optional, needs to be in the *.h comment
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_xclbin_get_section);
> +
Instead of allocating new memory and making copies of bits of *data

why not have the points reference data ?

The size operations look like translating big endian data to little endian.

This will break on a big endian host.

> +/* parse bitstream header */
> +int xrt_xclbin_parse_bitstream_header(const unsigned char *data,
> +				      unsigned int size,
> +				      struct hw_icap_bit_header *header)
> +{
> +	unsigned int index;
> +	unsigned int len;
> +	unsigned int tmp;
> +	unsigned int i;
> +
> +	memset(header, 0, sizeof(*header));
> +	/* Start Index at start of bitstream */
> +	index = 0;
> +
> +	/* Initialize HeaderLength.  If header returned early inidicates
> +	 * failure.

This side effect should be documented in the *.h comment.

Also the multi line comment is a bit weird, not sure if it is ok

> +	 */
> +	header->header_length = XHI_BIT_HEADER_FAILURE;
> +
> +	/* Get "Magic" length */
> +	header->magic_length = xhi_data_and_inc(data, &index, size);
> +	header->magic_length = (header->magic_length << 8) | xhi_data_and_inc(data, &index, size);
> +
> +	/* Read in "magic" */
> +	for (i = 0; i < header->magic_length - 1; i++) {
> +		tmp = xhi_data_and_inc(data, &index, size);
> +		if (i % 2 == 0 && tmp != XHI_EVEN_MAGIC_BYTE)
> +			return -1;	/* INVALID_FILE_HEADER_ERROR */
> +
> +		if (i % 2 == 1 && tmp != XHI_ODD_MAGIC_BYTE)
> +			return -1;	/* INVALID_FILE_HEADER_ERROR */
> +	}
> +
> +	/* Read null end of magic data. */
> +	tmp = xhi_data_and_inc(data, &index, size);
> +
> +	/* Read 0x01 (short) */
> +	tmp = xhi_data_and_inc(data, &index, size);
> +	tmp = (tmp << 8) | xhi_data_and_inc(data, &index, size);
> +
> +	/* Check the "0x01" half word */
> +	if (tmp != 0x01)
> +		return -1;	/* INVALID_FILE_HEADER_ERROR */
> +
> +	/* Read 'a' */
> +	tmp = xhi_data_and_inc(data, &index, size);
> +	if (tmp != 'a')
> +		return -1;	/* INVALID_FILE_HEADER_ERROR	*/
> +
> +	/* Get Design Name length */
> +	len = xhi_data_and_inc(data, &index, size);
> +	len = (len << 8) | xhi_data_and_inc(data, &index, size);
> +
> +	/* allocate space for design name and final null character. */
> +	header->design_name = vmalloc(len);
> +	if (!header->design_name)
> +		return -ENOMEM;
> +
> +	/* Read in Design Name */
> +	for (i = 0; i < len; i++)
> +		header->design_name[i] = xhi_data_and_inc(data, &index, size);
> +
> +	if (header->design_name[len - 1] != '\0')
> +		return -1;
> +
> +	header->version = strstr(header->design_name, "Version=") + strlen("Version=");
> +
> +	/* Read 'b' */
> +	tmp = xhi_data_and_inc(data, &index, size);
> +	if (tmp != 'b')
> +		return -1;	/* INVALID_FILE_HEADER_ERROR */
> +
> +	/* Get Part Name length */
> +	len = xhi_data_and_inc(data, &index, size);
> +	len = (len << 8) | xhi_data_and_inc(data, &index, size);
> +
> +	/* allocate space for part name and final null character. */
> +	header->part_name = vmalloc(len);
> +	if (!header->part_name)
> +		return -ENOMEM;
> +
> +	/* Read in part name */
> +	for (i = 0; i < len; i++)
> +		header->part_name[i] = xhi_data_and_inc(data, &index, size);
> +
> +	if (header->part_name[len - 1] != '\0')
> +		return -1;
> +
> +	/* Read 'c' */
> +	tmp = xhi_data_and_inc(data, &index, size);
> +	if (tmp != 'c')
> +		return -1;	/* INVALID_FILE_HEADER_ERROR */
> +
> +	/* Get date length */
> +	len = xhi_data_and_inc(data, &index, size);
> +	len = (len << 8) | xhi_data_and_inc(data, &index, size);
> +
> +	/* allocate space for date and final null character. */
> +	header->date = vmalloc(len);
> +	if (!header->date)
> +		return -ENOMEM;
> +
> +	/* Read in date name */
> +	for (i = 0; i < len; i++)
> +		header->date[i] = xhi_data_and_inc(data, &index, size);
> +
> +	if (header->date[len - 1] != '\0')
> +		return -1;
generally -EINVAL is more meaningful than -1
> +
> +	/* Read 'd' */
> +	tmp = xhi_data_and_inc(data, &index, size);
> +	if (tmp != 'd')
> +		return -1;	/* INVALID_FILE_HEADER_ERROR  */
> +
> +	/* Get time length */
> +	len = xhi_data_and_inc(data, &index, size);
> +	len = (len << 8) | xhi_data_and_inc(data, &index, size);
> +
> +	/* allocate space for time and final null character. */
> +	header->time = vmalloc(len);
> +	if (!header->time)
> +		return -ENOMEM;
> +
> +	/* Read in time name */
> +	for (i = 0; i < len; i++)
> +		header->time[i] = xhi_data_and_inc(data, &index, size);
> +
> +	if (header->time[len - 1] != '\0')
> +		return -1;
> +
> +	/* Read 'e' */
> +	tmp = xhi_data_and_inc(data, &index, size);
> +	if (tmp != 'e')
> +		return -1;	/* INVALID_FILE_HEADER_ERROR */
> +
> +	/* Get byte length of bitstream */
> +	header->bitstream_length = xhi_data_and_inc(data, &index, size);
> +	header->bitstream_length = (header->bitstream_length << 8) |
> +		xhi_data_and_inc(data, &index, size);
> +	header->bitstream_length = (header->bitstream_length << 8) |
> +		xhi_data_and_inc(data, &index, size);
> +	header->bitstream_length = (header->bitstream_length << 8) |
> +		xhi_data_and_inc(data, &index, size);

generally a problem

This is confusing, collect the bytes in a temp[] and construct the header->bitstream_length in on statement.

This is a case where xhi_data_and_inc return is not checked and if it failed could blow up later.

> +
> +	header->header_length = index;

index is not a good variable name if it going to be stored as a length.

consider changing it to something like current_length.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_xclbin_parse_bitstream_header);
> +
> +void xrt_xclbin_free_header(struct hw_icap_bit_header *header)
> +{
> +	vfree(header->design_name);
> +	vfree(header->part_name);
> +	vfree(header->date);
> +	vfree(header->time);
missing header->version
> +}
> +EXPORT_SYMBOL_GPL(xrt_xclbin_free_header);
> +
> +struct xrt_clock_desc {
> +	char	*clock_ep_name;
> +	u32	clock_xclbin_type;
> +	char	*clkfreq_ep_name;
> +} clock_desc[] = {
> +	{
> +		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL1,
> +		.clock_xclbin_type = CT_DATA,
> +		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K1,
> +	},
> +	{
> +		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL2,
> +		.clock_xclbin_type = CT_KERNEL,
> +		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K2,
> +	},
> +	{
> +		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL3,
> +		.clock_xclbin_type = CT_SYSTEM,
> +		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_HBM,
> +	},
> +};
> +
> +const char *xrt_clock_type2epname(enum CLOCK_TYPE type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
> +		if (clock_desc[i].clock_xclbin_type == type)
> +			return clock_desc[i].clock_ep_name;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(xrt_clock_type2epname);

What is clock stuff doing in xclbin ?

I think clock needs its own file

> +
> +static const char *clock_type2clkfreq_name(u32 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
> +		if (clock_desc[i].clock_xclbin_type == type)
> +			return clock_desc[i].clkfreq_ep_name;
> +	}
> +	return NULL;
> +}
> +
> +static int xrt_xclbin_add_clock_metadata(struct device *dev,
> +					 const struct axlf *xclbin,
> +					 char *dtb)
> +{
> +	int i;
> +	u16 freq;
> +	struct clock_freq_topology *clock_topo;
> +	int rc = xrt_xclbin_get_section(xclbin, CLOCK_FREQ_TOPOLOGY,
> +					(void **)&clock_topo, NULL);
> +
> +	if (rc)
> +		return 0;
failing is ok ?
> +
> +	for (i = 0; i < clock_topo->m_count; i++) {
> +		u8 type = clock_topo->m_clock_freq[i].m_type;
> +		const char *ep_name = xrt_clock_type2epname(type);
> +		const char *counter_name = clock_type2clkfreq_name(type);
> +
> +		if (!ep_name || !counter_name)
> +			continue;
> +
> +		freq = cpu_to_be16(clock_topo->m_clock_freq[i].m_freq_Mhz);
> +		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_FREQ,
> +				     &freq, sizeof(freq));
> +		if (rc)
> +			break;
> +
> +		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_CNT,
> +				     counter_name, strlen(counter_name) + 1);
> +		if (rc)
> +			break;
Failing in a loop, why isn't there some cleanup of the *set_prop() calls ?
> +	}
> +
> +	vfree(clock_topo);
> +
> +	return rc;
> +}
> +
> +int xrt_xclbin_get_metadata(struct device *dev, const struct axlf *xclbin, char **dtb)
> +{
> +	char *md = NULL, *newmd = NULL;
> +	u64 len;
*dtb = NULL;
> +	int rc = xrt_xclbin_get_section(xclbin, PARTITION_METADATA,
> +					(void **)&md, &len);
> +
> +	if (rc)
> +		goto done;
> +
> +	/* Sanity check the dtb section. */
> +	if (xrt_md_size(dev, md) > len) {
> +		rc = -EINVAL;
> +		goto done;
> +	}
> +
> +	newmd = xrt_md_dup(dev, md);
> +	if (!newmd) {
> +		rc = -EFAULT;
> +		goto done;
> +	}
> +	/* Convert various needed xclbin sections into dtb. */
> +	rc = xrt_xclbin_add_clock_metadata(dev, xclbin, newmd);

newmd is only valid here, but the above error handling jump here. change this to

if (!rc)

  *dtb = newmd

else

   vfree(newmd)

done:

  vfree(md)

  return rc;

> +
> +done:
> +	if (rc == 0)
> +		*dtb = newmd;
> +	else
> +		vfree(newmd);
> +	vfree(md);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(xrt_xclbin_get_metadata);
> diff --git a/include/uapi/linux/xrt/xclbin.h b/include/uapi/linux/xrt/xclbin.h
> new file mode 100644
> index 000000000000..53f140123ef1
> --- /dev/null
> +++ b/include/uapi/linux/xrt/xclbin.h
> @@ -0,0 +1,408 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + *  Xilinx FPGA compiled binary container format
> + *
> + *  Copyright (C) 2015-2021, Xilinx Inc
> + */
> +
> +#ifndef _XCLBIN_H_
> +#define _XCLBIN_H_
> +
> +#ifdef _WIN32

WIN32 ?

Only 1 other header has this ifdef

> +  #include <cstdint>
> +  #include <algorithm>
c++ is being assumed for windows
> +  #include "windows/uuid.h"
thank you for not including windows.h ;)
> +#else
> +  #if defined(__KERNEL__)
> +    #include <linux/types.h>
> +    #include <linux/uuid.h>
> +    #include <linux/version.h>
> +  #elif defined(__cplusplus)
> +    #include <cstdlib>
> +    #include <cstdint>
> +    #include <algorithm>
> +    #include <uuid/uuid.h>
> +  #else
> +    #include <stdlib.h>
> +    #include <stdint.h>
> +    #include <uuid/uuid.h>
> +  #endif
> +#endif
> +

Review these includes, some could be convenience includes.

ex/ linux/version.h with no obvious use of version macros.

struct axlf_header {
+	uint64_t m_length;		    /* Total size of the xclbin file */
.. snip ..
+	union {
+		char m_next_axlf[16];		/* Name of next xclbin file */
+						/* in the daisy chain */
+		uuid_t uuid;			/* uuid of this xclbin*/
+	};

As mentioned in an earlier patch, if uuid_t is larger than 16 bytes, axlf_header breaks.
while it is convenient to have this type here, it would be better this access was handled in another way.
Maybe a host specific function.

I also do not see a pragma pack, usually this is set of 1 so the compiler does not shuffle elements, increase size etc.

> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * DOC: Container format for Xilinx FPGA images
> + * The container stores bitstreams, metadata and firmware images.
> + * xclbin/xsabin is ELF-like binary container format. It is structured
is an ELF-like file format.  It is a structured
> + * series of sections. There is a file header followed by several section
> + * headers which is followed by sections. A section header points to an
> + * actual section. There is an optional signature at the end. The
> + * following figure illustrates a typical xclbin:
> + *
> + *     +---------------------+
> + *     |		     |
> + *     |       HEADER	     |
> + *     +---------------------+
> + *     |   SECTION  HEADER   |
> + *     |		     |
> + *     +---------------------+
> + *     |	 ...	     |
> + *     |		     |
> + *     +---------------------+
> + *     |   SECTION  HEADER   |
> + *     |		     |
> + *     +---------------------+
> + *     |       SECTION	     |
> + *     |		     |
> + *     +---------------------+
> + *     |	 ...	     |
> + *     |		     |
> + *     +---------------------+
> + *     |       SECTION	     |
> + *     |		     |
> + *     +---------------------+
> + *     |      SIGNATURE	     |
> + *     |      (OPTIONAL)     |
> + *     +---------------------+

This ascii art is a mixture of tabs and spaces, for someone with tab = 2 spaces, this will look messed up.

convert the tabs to spaces

> + */
> +
> +enum XCLBIN_MODE {
> +	XCLBIN_FLAT,

generally

all enums used in a file format should be initialized.

This likely should be

XCLBIN_FLAT = 0,

> +	XCLBIN_PR,
> +	XCLBIN_TANDEM_STAGE2,
> +	XCLBIN_TANDEM_STAGE2_WITH_PR,
> +	XCLBIN_HW_EMU,
> +	XCLBIN_SW_EMU,
> +	XCLBIN_MODE_MAX
> +};
> +
> +enum axlf_section_kind {
> +	BITSTREAM = 0,
> +	CLEARING_BITSTREAM,
> +	EMBEDDED_METADATA,
> +	FIRMWARE,
> +	DEBUG_DATA,
> +	SCHED_FIRMWARE,
> +	MEM_TOPOLOGY,
> +	CONNECTIVITY,
> +	IP_LAYOUT,
> +	DEBUG_IP_LAYOUT,
> +	DESIGN_CHECK_POINT,
> +	CLOCK_FREQ_TOPOLOGY,
> +	MCS,
> +	BMC,
> +	BUILD_METADATA,
> +	KEYVALUE_METADATA,
> +	USER_METADATA,
> +	DNA_CERTIFICATE,
> +	PDI,
> +	BITSTREAM_PARTIAL_PDI,
> +	PARTITION_METADATA,
> +	EMULATION_DATA,
> +	SYSTEM_METADATA,
> +	SOFT_KERNEL,
> +	ASK_FLASH,
> +	AIE_METADATA,
> +	ASK_GROUP_TOPOLOGY,
> +	ASK_GROUP_CONNECTIVITY
> +};
> +
> +enum MEM_TYPE {
> +	MEM_DDR3,
> +	MEM_DDR4,
> +	MEM_DRAM,
> +	MEM_STREAMING,
> +	MEM_PREALLOCATED_GLOB,
> +	MEM_ARE,
> +	MEM_HBM,
> +	MEM_BRAM,
> +	MEM_URAM,
> +	MEM_STREAMING_CONNECTION
> +};
> +
> +enum IP_TYPE {
> +	IP_MB = 0,
> +	IP_KERNEL,
> +	IP_DNASC,
> +	IP_DDR4_CONTROLLER,
> +	IP_MEM_DDR4,
> +	IP_MEM_HBM
> +};
> +
> +struct axlf_section_header {
> +	uint32_t m_sectionKind;		    /* Section type */
> +	char m_sectionName[16];		    /* Examples: "stage2", "clear1", */
> +					    /* "clear2", "ocl1", "ocl2, */
> +					    /* "ublaze", "sched" */
> +	uint64_t m_sectionOffset;	    /* File offset of section data */
> +	uint64_t m_sectionSize;		    /* Size of section data */
> +};
> +
> +struct axlf_header {
> +	uint64_t m_length;		    /* Total size of the xclbin file */
> +	uint64_t m_timeStamp;		    /* Number of seconds since epoch */
> +					    /* when xclbin was created */
> +	uint64_t m_featureRomTimeStamp;	    /* TimeSinceEpoch of the featureRom */
> +	uint16_t m_versionPatch;	    /* Patch Version */
> +	uint8_t m_versionMajor;		    /* Major Version - Version: 2.1.0*/
i did not see the version checked earlier, which one is expected ?
> +	uint8_t m_versionMinor;		    /* Minor Version */
> +	uint32_t m_mode;		    /* XCLBIN_MODE */
> +	union {
> +		struct {
> +			uint64_t m_platformId;	/* 64 bit platform ID: */
> +					/* vendor-device-subvendor-subdev */
> +			uint64_t m_featureId;	/* 64 bit feature id */
> +		} rom;
> +		unsigned char rom_uuid[16];	/* feature ROM UUID for which */
> +						/* this xclbin was generated */
> +	};
> +	unsigned char m_platformVBNV[64];	/* e.g. */
what is VBNV?
> +		/* xilinx:xil-accel-rd-ku115:4ddr-xpr:3.4: null terminated */
> +	union {
> +		char m_next_axlf[16];		/* Name of next xclbin file */
> +						/* in the daisy chain */
> +		uuid_t uuid;			/* uuid of this xclbin*/
> +	};
> +	char m_debug_bin[16];			/* Name of binary with debug */
> +						/* information */
> +	uint32_t m_numSections;			/* Number of section headers */
> +};
> +
> +struct axlf {
> +	char m_magic[8];			/* Should be "xclbin2\0"  */
> +	int32_t m_signature_length;		/* Length of the signature. */
> +						/* -1 indicates no signature */
> +	unsigned char reserved[28];		/* Note: Initialized to 0xFFs */
> +
> +	unsigned char m_keyBlock[256];		/* Signature for validation */
> +						/* of binary */
> +	uint64_t m_uniqueId;			/* axlf's uniqueId, use it to */
> +						/* skip redownload etc */
> +	struct axlf_header m_header;		/* Inline header */
> +	struct axlf_section_header m_sections[1];   /* One or more section */
> +						    /* headers follow */
> +};
> +
> +/* bitstream information */
> +struct xlnx_bitstream {
> +	uint8_t m_freq[8];
> +	char bits[1];
> +};
> +
> +/****	MEMORY TOPOLOGY SECTION ****/
> +struct mem_data {
> +	uint8_t m_type; /* enum corresponding to mem_type. */
> +	uint8_t m_used; /* if 0 this bank is not present */
> +	union {
> +		uint64_t m_size; /* if mem_type DDR, then size in KB; */
> +		uint64_t route_id; /* if streaming then "route_id" */
> +	};
> +	union {
> +		uint64_t m_base_address;/* if DDR then the base address; */
> +		uint64_t flow_id; /* if streaming then "flow id" */
> +	};
> +	unsigned char m_tag[16]; /* DDR: BANK0,1,2,3, has to be null */
> +			/* terminated; if streaming then stream0, 1 etc */
> +};
> +
> +struct mem_topology {
> +	int32_t m_count; /* Number of mem_data */
> +	struct mem_data m_mem_data[1]; /* Should be sorted on mem_type */
> +};
> +
> +/****	CONNECTIVITY SECTION ****/
> +/* Connectivity of each argument of Kernel. It will be in terms of argument

This section does not make sense.

Likely you mean some algorithm kernel, rather than the linux kernel.

> + * index associated. For associating kernel instances with arguments and
> + * banks, start at the connectivity section. Using the m_ip_layout_index
> + * access the ip_data.m_name. Now we can associate this kernel instance
> + * with its original kernel name and get the connectivity as well. This
> + * enables us to form related groups of kernel instances.
> + */
> +
> +struct connection {
> +	int32_t arg_index; /* From 0 to n, may not be contiguous as scalars */
> +			   /* skipped */
> +	int32_t m_ip_layout_index; /* index into the ip_layout section. */
> +			   /* ip_layout.m_ip_data[index].m_type == IP_KERNEL */
> +	int32_t mem_data_index; /* index of the m_mem_data . Flag error is */
> +				/* m_used false. */
> +};
> +
> +struct connectivity {
> +	int32_t m_count;
> +	struct connection m_connection[1];
> +};
> +
> +/****	IP_LAYOUT SECTION ****/
> +
> +/* IP Kernel */
> +#define IP_INT_ENABLE_MASK	  0x0001
> +#define IP_INTERRUPT_ID_MASK  0x00FE
> +#define IP_INTERRUPT_ID_SHIFT 0x1
> +
> +enum IP_CONTROL {
> +	AP_CTRL_HS = 0,
> +	AP_CTRL_CHAIN = 1,
> +	AP_CTRL_NONE = 2,
> +	AP_CTRL_ME = 3,
> +	ACCEL_ADAPTER = 4
assigning beyond the first is not necessary unless there are dups or gaps
> +};
> +
> +#define IP_CONTROL_MASK	 0xFF00
> +#define IP_CONTROL_SHIFT 0x8
> +
> +/* IPs on AXI lite - their types, names, and base addresses.*/
> +struct ip_data {
> +	uint32_t m_type; /* map to IP_TYPE enum */
> +	union {
> +		uint32_t properties; /* Default: 32-bits to indicate ip */
> +				     /* specific property. */
> +		/* m_type: IP_KERNEL
> +		 *	    m_int_enable   : Bit  - 0x0000_0001;
> +		 *	    m_interrupt_id : Bits - 0x0000_00FE;
> +		 *	    m_ip_control   : Bits = 0x0000_FF00;
> +		 */
> +		struct {		 /* m_type: IP_MEM_* */
> +			uint16_t m_index;
> +			uint8_t m_pc_index;
> +			uint8_t unused;
> +		} indices;
> +	};
> +	uint64_t m_base_address;
> +	uint8_t m_name[64]; /* eg Kernel name corresponding to KERNEL */
> +			    /* instance, can embed CU name in future. */
> +};
> +
> +struct ip_layout {
> +	int32_t m_count;
> +	struct ip_data m_ip_data[1]; /* All the ip_data needs to be sorted */
> +				     /* by m_base_address. */

general

doing the bla[1] for c++ ?

Tom

> +};
> +
> +/*** Debug IP section layout ****/
> +enum DEBUG_IP_TYPE {
> +	UNDEFINED = 0,
> +	LAPC,
> +	ILA,
> +	AXI_MM_MONITOR,
> +	AXI_TRACE_FUNNEL,
> +	AXI_MONITOR_FIFO_LITE,
> +	AXI_MONITOR_FIFO_FULL,
> +	ACCEL_MONITOR,
> +	AXI_STREAM_MONITOR,
> +	AXI_STREAM_PROTOCOL_CHECKER,
> +	TRACE_S2MM,
> +	AXI_DMA,
> +	TRACE_S2MM_FULL
> +};
> +
> +struct debug_ip_data {
> +	uint8_t m_type; /* type of enum DEBUG_IP_TYPE */
> +	uint8_t m_index_lowbyte;
> +	uint8_t m_properties;
> +	uint8_t m_major;
> +	uint8_t m_minor;
> +	uint8_t m_index_highbyte;
> +	uint8_t m_reserved[2];
> +	uint64_t m_base_address;
> +	char	m_name[128];
> +};
> +
> +struct debug_ip_layout {
> +	uint16_t m_count;
> +	struct debug_ip_data m_debug_ip_data[1];
> +};
> +
> +/* Supported clock frequency types */
> +enum CLOCK_TYPE {
> +	CT_UNUSED = 0,			   /* Initialized value */
> +	CT_DATA	  = 1,			   /* Data clock */
> +	CT_KERNEL = 2,			   /* Kernel clock */
> +	CT_SYSTEM = 3			   /* System Clock */
> +};
> +
> +/* Clock Frequency Entry */
> +struct clock_freq {
> +	uint16_t m_freq_Mhz;		   /* Frequency in MHz */
> +	uint8_t m_type;			   /* Clock type (enum CLOCK_TYPE) */
> +	uint8_t m_unused[5];		   /* Not used - padding */
> +	char m_name[128];		   /* Clock Name */
> +};
> +
> +/* Clock frequency section */
> +struct clock_freq_topology {
> +	int16_t m_count;		   /* Number of entries */
> +	struct clock_freq m_clock_freq[1]; /* Clock array */
> +};
> +
> +/* Supported MCS file types */
> +enum MCS_TYPE {
> +	MCS_UNKNOWN = 0,		   /* Initialized value */
> +	MCS_PRIMARY = 1,		   /* The primary mcs file data */
> +	MCS_SECONDARY = 2,		   /* The secondary mcs file data */
> +};
> +
> +/* One chunk of MCS data */
> +struct mcs_chunk {
> +	uint8_t m_type;			   /* MCS data type */
> +	uint8_t m_unused[7];		   /* padding */
> +	uint64_t m_offset;		   /* data offset from the start of */
> +					   /* the section */
> +	uint64_t m_size;		   /* data size */
> +};
> +
> +/* MCS data section */
> +struct mcs {
> +	int8_t m_count;			   /* Number of chunks */
> +	int8_t m_unused[7];		   /* padding */
> +	struct mcs_chunk m_chunk[1];	   /* MCS chunks followed by data */
> +};
> +
> +/* bmc data section */
> +struct bmc {
> +	uint64_t m_offset;		   /* data offset from the start of */
> +					   /* the section */
> +	uint64_t m_size;		   /* data size (bytes) */
> +	char m_image_name[64];		   /* Name of the image */
> +					   /* (e.g., MSP432P401R) */
> +	char m_device_name[64];		   /* Device ID	(e.g., VCU1525)	 */
> +	char m_version[64];
> +	char m_md5value[33];		   /* MD5 Expected Value */
> +				/* (e.g., 56027182079c0bd621761b7dab5a27ca)*/
> +	char m_padding[7];		   /* Padding */
> +};
> +
> +/* soft kernel data section, used by classic driver */
> +struct soft_kernel {
> +	/** Prefix Syntax:
> +	 *  mpo - member, pointer, offset
> +	 *  This variable represents a zero terminated string
> +	 *  that is offseted from the beginning of the section.
> +	 *  The pointer to access the string is initialized as follows:
> +	 *  char * pCharString = (address_of_section) + (mpo value)
> +	 */
> +	uint32_t mpo_name;	   /* Name of the soft kernel */
> +	uint32_t m_image_offset;   /* Image offset */
> +	uint32_t m_image_size;	   /* Image size */
> +	uint32_t mpo_version;	   /* Version */
> +	uint32_t mpo_md5_value;	   /* MD5 checksum */
> +	uint32_t mpo_symbol_name;  /* Symbol name */
> +	uint32_t m_num_instances;  /* Number of instances */
> +	uint8_t padding[36];	   /* Reserved for future use */
> +	uint8_t reservedExt[16];   /* Reserved for future extended data */
> +};
> +
> +enum CHECKSUM_TYPE {
> +	CST_UNKNOWN = 0,
> +	CST_SDBM = 1,
> +	CST_LAST
> +};
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif

